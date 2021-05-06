require 'rails_helper'

RSpec.describe BudgetItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:is_recurring) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:date) }
    it { should validate_inclusion_of(:recur_unit)
         .in_array(["months", "days"])}
    it { should validate_inclusion_of(:type)
         .in_array(["income", "expense"])}
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe '#first_instance_this_month' do
    before :each do 
      # sets the date for testing to May 18th, 2021, at 1:00 am
      # since we're going to be testing budget items with different 
      # starting and ending dates, it'll be useful to keep the current date
      # fixed
      @current_month = 5 
      @current_year = 2021
      travel_to DateTime.new(@current_year,@current_month,18,1,0,0)
    end

    after :each do
      travel_back
    end

    context 'given a non-recurring budget item' do
      context 'if its date is from a previous month' do
        context 'if it\'s an expense' do
          it 'will return nil' do 
            previous_month = @current_month - 1
            date = DateTime.new(@current_year,previous_month,18,3,2,1)
            expense = FactoryBot.build(:budget_item, :expense, :not_recurring,
                                       date: date)

            expect(expense.first_instance_this_month).to be_nil
          end
        end

        context 'if it\'s an income item' do
          it 'will return nil' do
            previous_month = @current_month - 1
            date = DateTime.new(@current_year,previous_month,18,3,2,1)
            income = FactoryBot.build(:budget_item, :income, :not_recurring,
                                      date: date)

            expect(income.first_instance_this_month).to be_nil
          end
        end
      end

      context 'if its date is from the current month' do
        context 'if it\'s an expense' do
          it 'will return the day of the month from its date' do 
            day = 3
            date = DateTime.new(@current_year,@current_month,day,3,2,1)
            expense = FactoryBot.build(:budget_item, :expense, :not_recurring,
                                       date: date)

            expect(expense.first_instance_this_month).to eq(day)
          end
        end

        context 'if it\'s an income item' do
          it 'will return nil' do
            day = 17
            date = DateTime.new(@current_year,@current_month,day,3,2,1)
            income = FactoryBot.build(:budget_item, :expense, :not_recurring,
                                      date: date)

            expect(income.first_instance_this_month).to eq(day)
          end
        end
      end
    end

    context 'given a recurring budget item' do
      context 'if its recurring period is under a month' do
        context 'if its an expense' do
          it 'will give the first day it recurs in the given month' do 
            previous_year = @current_year - 1 
            month = 7 
            day = 3
            date = DateTime.new(previous_year, month, day, 14, 0, 0)
            recur_period = 18 #days
            recur_day = 5
            expense = FactoryBot.build(:budget_item, :expense, :recurring,
                                       date: date, recur_period: recur_period, 
                                       recur_unit: 'days')

            expect(expense.first_instance_this_month).to eq(recur_day)
          end
        end

        context 'if its an income item' do
          it 'will give the first day it recurs in the given month' do 
            previous_year = @current_year - 1 
            month = 7 
            day = 4
            date = DateTime.new(previous_year, month, day, 14, 0, 0)
            recur_period = 18 #days
            recur_day = 6
            income = FactoryBot.build(:budget_item, :income, :recurring,
                                      date: date, recur_period: recur_period, 
                                      recur_unit: 'days')

            expect(income.first_instance_this_month).to eq(recur_day)
          end
        end
      end

      context 'if its recurring period is over a month' do
        context 'if its recurring period is expressed in days' do
          context 'if it will not recur that month' do
            context 'if it\'s an expense' do
              it 'should return nil' do 
                month = 4
                day = 30
                date = DateTime.new(@current_year, month, day, 3, 33, 0)
                recur_period = 32 #days
                expense = FactoryBot.build(:budget_item, :expense, :recurring,
                                           date: date, recur_period: recur_period,
                                           recur_unit: 'days')

                expect(expense.first_instance_this_month).to be_nil
              end
            end

            context 'if it\'s an income item' do
              it 'should return nil' do 
                month = 3
                day = 10
                date = DateTime.new(@current_year, month, day, 3, 33, 0)
                recur_period = 90 #days
                income = FactoryBot.build(:budget_item, :income, :recurring,
                                          date: date, recur_period: recur_period,
                                          recur_unit: 'days')

                expect(income.first_instance_this_month).to be_nil
              end
            end
          end

          context 'if it will recur that month' do
            context 'if it\'s an expense' do
              it 'should return the date it recurs on in that month' do
                month = 4
                day = 29
                date = DateTime.new(@current_year, month, day, 3, 33, 0)
                recur_period = 32 #days
                expense = FactoryBot.build(:budget_item, :expense, :recurring,
                                           date: date, recur_period: recur_period,
                                           recur_unit: 'days')

                expect(expense.first_instance_this_month).to eq(31)
              end
            end

            context 'if it\'s an income item' do
              it 'should return the date it recurs on that month' do
                month = 3
                day = 28
                date = DateTime.new(@current_year, month, day, 3, 33, 0)
                recur_period = 32 #days
                income = FactoryBot.build(:budget_item, :income, :recurring,
                                          date: date, recur_period: recur_period,
                                          recur_unit: 'days')

                expect(income.first_instance_this_month).to eq(31)
              end
            end
          end
        end

        context 'if its recurring period is in months' do
          context 'if it will recur that month and the month ' \
            'is longer than the day of the month in the initial ' \
            'recur date' do
              context 'if it\'s an expense' do
                it 'should return the recur date for that month' do
                  month = 3
                  day = 7
                  date = DateTime.new(@current_year, month, day, 3, 33, 0)
                  recur_period = 2 #month
                  expense = FactoryBot.build(:budget_item, :expense, :recurring,
                                             date: date, recur_period: recur_period,
                                             recur_unit: 'months')

                  expect(expense.first_instance_this_month).to eq(7)
                end
              end

              context 'if it\'s an income item' do
                it 'should return the recur date for that month' do
                  month = 1
                  day = 17
                  date = DateTime.new(@current_year, month, day, 3, 33, 0)
                  recur_period = 2 #month
                  income = FactoryBot.build(:budget_item, :income, :recurring,
                                             date: date, recur_period: recur_period,
                                             recur_unit: 'months')

                  expect(income.first_instance_this_month).to eq(17)
                end
              end
            end

            context 'if it will recur that month and the month ' \
              'is shorter than the day of the month in the initial ' \
              'recur date' do
                context 'if it\'s an expense' do
                  it 'should return the last day of that month' do
                    travel_to DateTime.new(2021, 2, 13, 7, 30, 0)

                    month = 1
                    day = 30
                    date = DateTime.new(@current_year, month, day, 3, 33, 0)
                    recur_period = 1 #month
                    expense = FactoryBot.build(:budget_item, :expense, :recurring,
                                              date: date, recur_period: recur_period,
                                              recur_unit: 'months')

                    expect(expense.first_instance_this_month).to eq(28)
                  end
                end

                context 'if it\'s an income item' do
                  it 'should return the last day of that month' do
                    travel_to DateTime.new(2021, 2, 13, 7, 30, 0)

                    month = 1
                    day = 30
                    date = DateTime.new(@current_year, month, day, 3, 33, 0)
                    recur_period = 1 #month
                    income = FactoryBot.build(:budget_item, :income, :recurring,
                                              date: date, recur_period: recur_period,
                                              recur_unit: 'months')

                    expect(income.first_instance_this_month).to eq(28)
                  end
                end
              end

            context 'if it will not recur that month' do
              context 'if it\'s an expense' do
                it 'should return nil' do
                  month = 4
                  day = 7
                  date = DateTime.new(@current_year, month, day, 3, 33, 0)
                  recur_period = 2 #month
                  expense = FactoryBot.build(:budget_item, :expense, :recurring,
                                             date: date, recur_period: recur_period,
                                             recur_unit: 'months')

                  expect(expense.first_instance_this_month).to be_nil
                end
              end

              context 'if it\'s an income item' do
                it 'return nil' do
                  month = 2
                  day = 17
                  date = DateTime.new(@current_year, month, day, 3, 33, 0)
                  recur_period = 2 #month
                  income = FactoryBot.build(:budget_item, :income, :recurring,
                                             date: date, recur_period: recur_period,
                                             recur_unit: 'months')

                  expect(income.first_instance_this_month).to be_nil
                end
              end
            end
        end
      end

      context 'if its end date falls before its first recur date that month' do
        it 'should return nil' do
            previous_year = @current_year - 1 
            month = 7 
            day = 4
            date = DateTime.new(previous_year, month, day, 14, 0, 0)
            recur_period = 18 #days
            recur_day = 6
            end_date = DateTime.new(@current_year, @current_month, 1, 3, 0, 0)
            income = FactoryBot.build(:budget_item, :income, :recurring,
                                      date: date, recur_period: recur_period, 
                                      recur_unit: 'days', end_date: end_date)

            expect(income.first_instance_this_month).to be_nil
        end
      end

      context 'if its end date falls on its first recur date that month' do
        it 'should return the first recur date that month' do
            previous_year = @current_year - 1 
            month = 7 
            day = 4
            date = DateTime.new(previous_year, month, day, 14, 0, 0)
            recur_period = 18 #days
            recur_day = 6
            end_date = DateTime.new(@current_year, @current_month, 
                                    recur_day, 3, 0, 0)
            income = FactoryBot.build(:budget_item, :income, :recurring,
                                      date: date, recur_period: recur_period, 
                                      recur_unit: 'days', end_date: end_date)

        end
      end
    end
  end
end
