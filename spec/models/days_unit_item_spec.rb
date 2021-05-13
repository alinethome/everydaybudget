require 'rails_helper'
require 'budget_item_spec_helper'

RSpec.describe DaysUnitItem, type: :model do
  let(:expense_days_item) { FactoryBot.build(:days_item, :expense) }
  let(:income_days_item) { FactoryBot.build(:days_item, :income) }


  describe '#first_instance_this_month' do
    before do 
      # sets the date for testing to May 18th, 2021, at 1:00 am
      # since we're going to be testing budget items with different 
      # starting and ending dates, it'll be useful to keep the current date
      # fixed
      @current_month = 5 
      @current_year = 2021
      travel_to DateTime.new(@current_year,@current_month,18,1,0,0)
    end

    after do
      travel_back
    end

    describe 'given an expense' do
      describe 'with no end date' do
        describe 'that will recur in the current month' do
          it 'returns the first day it will recur in the current month' do
            set_start_date(item: expense_days_item, year: @current_year - 1,
                           month: 7, day: 3)
            expense_days_item.recur_period = 18

            recur_day = 5
            expect(expense_days_item.first_instance_this_month).to eq(recur_day)
          end

          context 'that will recur the first of the month' do
            it 'returns 1' do
              set_start_date(item: expense_days_item, year: @current_year,
                             month: 4, day: 29)
              expense_days_item.recur_period = 2

              recur_day = 1
              expect(expense_days_item.first_instance_this_month).to eq(recur_day)
            end
          end

          context 'with a start date in the current month' do
            it 'will return the start date\'s day' do
              start_day = 13
              set_start_date(item: expense_days_item, year: @current_year,
                             month: @current_month, day: start_day)
              expense_days_item.recur_period = 4

              expect(expense_days_item.
                     first_instance_this_month).to eq(start_day)
            end
          end
        end

        describe 'that will not recur in the current month' do
          it 'returns nil' do 
            set_start_date(item: expense_days_item, year: @current_year,
                           month: 4, day: 17) 
            expense_days_item.recur_period = 60

            expect(expense_days_item.first_instance_this_month).to be_nil
          end
        end
      end

      describe 'with an end date before the current month' do
        it 'returns nil' do 
          set_start_date(item: expense_days_item, year: @current_year - 1,
                         month: 7, day: 3)
          set_end_date(item: expense_days_item, year: @current_year,
                       month: 4, day: 30)
          expense_days_item.recur_period = 18

          expect(expense_days_item.first_instance_this_month).to be_nil
        end
      end

      describe 'with an end date in the current month' do
        describe 'if the end date falls before the first recur would occur' do
          it 'returns nil' do
            set_start_date(item: expense_days_item, year: @current_year - 1,
                           month: 7, day: 3) 
            set_end_date(item: expense_days_item, year: @current_year, 
                         month: @current_month, day: 1)
            expense_days_item.recur_period = 18

            expect(expense_days_item.first_instance_this_month).to be_nil
          end
        end

        describe 'if the end date falls after the first recur would occur' do
          it 'returns the first recur of the month' do
            set_start_date(item: expense_days_item, year: @current_year - 1,
                           month: 7, day: 3)
            set_end_date(item: expense_days_item, year: @current_year,
                         month: @current_month, day: 6)
            expense_days_item.recur_period = 18

            recur_day = 5
            expect(expense_days_item.
                   first_instance_this_month).to eq(recur_day)
          end
        end
      end
    end

    describe 'given an income item' do
      describe 'with no end date' do
        describe 'that will recur in the current month' do
          it 'returns the first day it will recur in the current month' do
            set_start_date(item: income_days_item, year: @current_year - 1,
                           month: 7, day: 4)
            income_days_item.recur_period = 18

            recur_day = 6
            expect(income_days_item.first_instance_this_month).to eq(recur_day)
          end

          context 'that will recur the first of the month' do
            it 'returns 1' do
              set_start_date(item: income_days_item, year: @current_year,
                             month: 4, day: 30)
              income_days_item.recur_period = 1

              recur_day = 1
              expect(income_days_item.first_instance_this_month).to eq(recur_day)
            end
          end

          context 'with a start date in the current month' do
            it 'will return the start date\'s day' do
              start_day = 31
              set_start_date(item: income_days_item, year: @current_year,
                             month: @current_month, day: start_day)
              income_days_item.recur_period = 4

              expect(income_days_item.
                     first_instance_this_month).to eq(start_day)
            end
          end
        end

        describe 'that will not recur in the current month' do
          it 'returns nil' do 
            set_start_date(item: income_days_item, year: @current_year,
                           month: 4, day: 17)
            income_days_item.recur_period = 100

            expect(income_days_item.first_instance_this_month).to be_nil
          end
        end
      end

      describe 'with an end date before the current month' do
        it 'returns nil' do 
          set_start_date(item: income_days_item, year: @current_year - 1,
                         month: 7, day: 3) 
          set_end_date(item: income_days_item, year: @current_year,
                       month: 4, day: 30)
          income_days_item.recur_period = 18

          expect(income_days_item.first_instance_this_month).to be_nil
        end
      end

      describe 'with an end date in the current month' do
        describe 'if the end date falls before the first recur would occur' do
          it 'returns nil' do
            set_start_date(item: income_days_item, year: @current_year - 1,
                           month: 7, day: 3)
            set_end_date(item: income_days_item, year: @current_year, 
                         month: @current_month, day: 1)
            income_days_item.recur_period = 18

            expect(income_days_item.first_instance_this_month).to be_nil
          end
        end

        describe 'if the end date falls after the first recur would occur' do
          it 'returns the first recur of the month' do
            set_start_date(item: income_days_item, year: @current_year - 1,
                           month: 7, day: 3)
            set_end_date(item: income_days_item, year: @current_year,
                         month: @current_month, day: 6)
            income_days_item.recur_period = 18

            recur_day = 5
            expect(income_days_item.
                   first_instance_this_month).to eq(recur_day)
          end
        end
      end
    end
  end

  describe '#instances_this_month' do
    before do 
      # sets the date for testing to May 18th, 2021, at 1:00 am
      # since we're going to be testing budget items with different 
      # starting and ending dates, it'll be useful to keep the current date
      # fixed
      @current_month = 5 
      @current_year = 2021
      travel_to DateTime.new(@current_year,@current_month,18,1,0,0)
    end

    after do
      travel_back
    end

    describe 'given an expense' do
      describe 'if there is no end_date' do
        describe 'if it will recur that month' do
          it 'will return an array of all the recur days that month' do
            set_start_date(item: expense_days_item, year: @current_year,
                           month: @current_month, day: 4) 
            expense_days_item.recur_period = 9

            expect(expense_days_item.
                   instances_this_month).to eq([4, 13, 22, 31])
          end
        end

        describe 'if it won\'t recur that month' do
          it 'will return an empty array' do
            set_start_date(item: expense_days_item, year: @current_year,
                           month: @current_month - 1, day: 30) 
            expense_days_item.recur_period = 32

            expect(expense_days_item.
                   instances_this_month).to eq([])
          end
        end
      end

      describe 'if the end date occurs before the current month' do
        it 'will return an empty array' do
          set_start_date(item: expense_days_item, year: @current_year,
                         month: @current_month - 1, day: 1) 
          set_end_date(item: expense_days_item, year: @current_year, 
                       month: @current_month - 1, day: 30)
          expense_days_item.recur_period = 5

          expect(expense_days_item.
                 instances_this_month).to eq([])
        end
      end

      describe 'if the end date occurs in the current month' do
        describe 'if the end date\'s day occurs before the first recur' do
          it 'will return an empty array' do
            set_start_date(item: expense_days_item, year: @current_year,
                           month: @current_month - 1, day: 30) 
            set_end_date(item: expense_days_item, year: @current_year, 
                         month: @current_month, day: 4)
            expense_days_item.recur_period = 5

            expect(expense_days_item.
                   instances_this_month).to eq([])
          end
        end

        describe 'if the end date\'s day occurs after the first recur' do
          it 'will return an array of all the recur days that month' do
            set_start_date(item: expense_days_item, year: @current_year,
                           month: @current_month - 1, day: 30) 
            set_end_date(item: expense_days_item, year: @current_year, 
                         month: @current_month, day: 27)
            expense_days_item.recur_period = 5

            expect(expense_days_item.
                   instances_this_month).to eq([5, 10, 15, 20, 25])
          end
        end
      end

      describe 'given an income item' do
        describe 'if there is no end_date' do
          describe 'if it will recur that month' do
            it 'will return an array of all the recur days that month' do
              set_start_date(item: income_days_item, year: @current_year,
                             month: @current_month, day: 4) 
              income_days_item.recur_period = 9

              expect(income_days_item.
                     instances_this_month).to eq([4, 13, 22, 31])
            end
          end

          describe 'if it won\'t recur that month' do
            it 'will return an empty array' do
              set_start_date(item: income_days_item, year: @current_year,
                             month: @current_month - 1, day: 30) 
              income_days_item.recur_period = 32

              expect(income_days_item.
                     instances_this_month).to eq([])
            end
          end
        end

        describe 'if the end date occurs before the current month' do
          it 'will return an empty array' do
            set_start_date(item: income_days_item, year: @current_year,
                           month: @current_month - 1, day: 1) 
            set_end_date(item: income_days_item, year: @current_year, 
                         month: @current_month - 1, day: 30)
            income_days_item.recur_period = 5

            expect(income_days_item.
                   instances_this_month).to eq([])
          end
        end

        describe 'if the end date occurs in the current month' do
          describe 'if the end date\'s day occurs before the first recur' do
            it 'will return an empty array' do
              set_start_date(item: income_days_item, year: @current_year,
                             month: @current_month - 1, day: 30) 
              set_end_date(item: income_days_item, year: @current_year, 
                           month: @current_month, day: 4)
              income_days_item.recur_period = 5

              expect(income_days_item.
                     instances_this_month).to eq([])
            end
          end

          describe 'if the end date\'s day occurs after the first recur' do
            it 'will return an array of all the recur days that month' do
              set_start_date(item: income_days_item, year: @current_year,
                             month: @current_month - 1, day: 30) 
              set_end_date(item: income_days_item, year: @current_year, 
                           month: @current_month, day: 27)
              income_days_item.recur_period = 5

              expect(income_days_item.
                     instances_this_month).to eq([5, 10, 15, 20, 25])
            end
          end
        end
      end
    end
  end

  describe '#total_monthly_amount' do
    before do 
      # sets the date for testing to May 18th, 2021, at 1:00 am
      # since we're going to be testing budget items with different 
      # starting and ending dates, it'll be useful to keep the current date
      # fixed
      @current_month = 5 
      @current_year = 2021
      travel_to DateTime.new(@current_year,@current_month,18,1,0,0)
    end

    after do
      travel_back
    end

    describe 'given an expense' do
      describe 'if it has no end date' do
        describe 'if it will not recur that month' do
          it 'returns zero' do
            set_start_date(item: expense_days_item, year: @current_year,
                           month: 4, day: 30)
            expense_days_item.recur_period = 32

            expect(expense_days_item.total_monthly_amount).to eq(0)
          end
        end

        describe 'if it will recur that month' do
          it 'returns minus its amount times the recur instances' do
            set_start_date(item: expense_days_item, year: @current_year,
                           month: 4, day: 30)
            expense_days_item.recur_period = 10
            recur_instances = 3
            amount = 13
            expense_days_item.amount = amount

            expect(expense_days_item.
                   total_monthly_amount).to eq(-amount*recur_instances)
          end
        end

        describe 'if its start date is in that month' do
          it 'returns minus its amount times the recur instances' do
            set_start_date(item: expense_days_item, year: @current_year,
                           month: @current_month, day: 11)
            expense_days_item.recur_period = 10
            recur_instances = 3
            amount = 29
            expense_days_item.amount = amount

            expect(expense_days_item.
                   total_monthly_amount).to eq(-amount*recur_instances)
          end
        end
      end

      describe 'if its end date occurs earlier than the current month' do
        it 'returns zero' do
            set_start_date(item: expense_days_item, year: @current_year,
                           month: 1, day: 11)
            set_end_date(item: expense_days_item, year: @current_year,
                         month: @current_month - 1, day: 30)
            expense_days_item.recur_period = 17

            expect(expense_days_item.
                   total_monthly_amount).to eq(0)
        end
      end

      describe 'if its end date occurs in the current month' do
        describe 'if its end date occurs earlier than the first recur' do
          it 'returns zero' do
            set_start_date(item: expense_days_item, year: @current_year,
                           month: @current_month - 1, day: 29)
            set_end_date(item: expense_days_item, year: @current_year,
                         month: @current_month, day: 15)
            expense_days_item.recur_period = 17

            expect(expense_days_item.
                   total_monthly_amount).to eq(0)
          end
        end

        describe 'if its end date occurs after the first recur' do
          it 'returns minus its amount times the recur instances' do
            set_start_date(item: expense_days_item, year: @current_year,
                           month: @current_month - 1, day: 29)
            set_end_date(item: expense_days_item, year: @current_year,
                         month: @current_month, day: 10)
            amount = 999
            recur_instances = 1
            expense_days_item.recur_period = 10
            expense_days_item.amount = amount

            expect(expense_days_item.
                   total_monthly_amount).to eq(-amount*recur_instances)
          end
        end
      end
    end

    describe 'given an income item' do
      describe 'if it has no end date' do
        describe 'if it will not recur that month' do
          it 'returns zero' do
            set_start_date(item: income_days_item, year: @current_year,
                           month: 4, day: 30)
            income_days_item.recur_period = 32

            expect(income_days_item.total_monthly_amount).to eq(0)
          end
        end

        describe 'if it will recur that month' do
          it 'returns its amount times the recur instances' do
            set_start_date(item: income_days_item, year: @current_year,
                           month: 4, day: 30)
            income_days_item.recur_period = 10
            recur_instances = 3
            amount = 13
            income_days_item.amount = amount

            expect(income_days_item.
                   total_monthly_amount).to eq(amount*recur_instances)
          end
        end

        describe 'if its start date is in that month' do
          it 'returns its amount times the recur instances' do
            set_start_date(item: income_days_item, year: @current_year,
                           month: @current_month, day: 11)
            income_days_item.recur_period = 10
            recur_instances = 3
            amount = 29
            income_days_item.amount = amount

            expect(income_days_item.
                   total_monthly_amount).to eq(amount*recur_instances)
          end
        end
      end

      describe 'if its end date occurs earlier than the current month' do
        it 'returns zero' do
            set_start_date(item: income_days_item, year: @current_year,
                           month: 1, day: 11)
            set_end_date(item: income_days_item, year: @current_year,
                         month: @current_month - 1, day: 30)
            income_days_item.recur_period = 17

            expect(income_days_item.
                   total_monthly_amount).to eq(0)
        end
      end

      describe 'if its end date occurs in the current month' do
        describe 'if its end date occurs earlier than the first recur' do
          it 'returns zero' do
            set_start_date(item: income_days_item, year: @current_year,
                           month: @current_month - 1, day: 29)
            set_end_date(item: income_days_item, year: @current_year,
                         month: @current_month, day: 15)
            income_days_item.recur_period = 17

            expect(income_days_item.
                   total_monthly_amount).to eq(0)
          end
        end

        describe 'if its end date occurs after the first recur' do
          it 'returns its amount times the recur instances' do
            set_start_date(item: income_days_item, year: @current_year,
                           month: @current_month - 1, day: 29)
            set_end_date(item: income_days_item, year: @current_year,
                         month: @current_month, day: 10)
            amount = 999
            recur_instances = 1
            income_days_item.recur_period = 10
            income_days_item.amount = amount

            expect(income_days_item.
                   total_monthly_amount).to eq(amount*recur_instances)
          end
        end
      end
    end
  end
end
