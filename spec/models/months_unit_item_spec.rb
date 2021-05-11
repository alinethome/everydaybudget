require 'rails_helper'

RSpec.describe MonthsUnitItem, type: :model do
  let(:expense_months_item) { FactoryBot.build(:months_item, :expense) }
  let(:income_months_item) { FactoryBot.build(:months_item, :income) }

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

    context 'given an expense' do
      context 'if it would recur in the given month' do
        context 'if it doesn\'t have an end date' do 
          context 'if the current month is longer than its start day' do
            it 'returns its start_date\'s day' do
              start_day = 30
              set_start_date(item: expense_months_item, year: @current_year,
                             month: 3, day: start_day)
              expense_months_item.recur_period = 2 #months

              expect(expense_months_item.
                     first_instance_this_month).to eq(start_day)
            end
          end

          context 'if the current month is shorter than its start day' do
            it 'returns the last day of the current month' do
              travel_to DateTime.new(2021, 2, 13, 7, 30, 0) # february
              days_in_february = 28

              set_start_date(item: expense_months_item, year: @current_year,
                             month: 1, day: 30)
              expense_months_item.recur_period = 1 

              expect(expense_months_item.
                     first_instance_this_month).to eq(days_in_february)
            end
          end
        end

        context 'if it has an end date' do
          context 'if the end date is before the current month' do
            it 'returns nil' do
              set_start_date(item: expense_months_item, year: @current_year,
                             month: 1, day: 30)
              set_end_date(item: expense_months_item, year: @current_year,
                             month: 3, day: 1)
              expense_months_item.recur_period = 1 #month

              expect(expense_months_item.
                     first_instance_this_month).to be_nil
            end
          end

          context 'if the end date is in the current month' do
            context 'if the end date is before its start day' do
              it 'returns nil' do
                set_start_date(item: expense_months_item, 
                               year: @current_year - 1, month: 7,
                               day: 4)
                set_end_date(item: expense_months_item, 
                               year: @current_year, month: @current_month,
                               day: 3)
                expense_months_item.recur_period = 2 # months

                expect(expense_months_item.
                       first_instance_this_month).to be_nil
              end
            end

            context 'if the end date is after it\'s start day' do
              it 'returns its start day' do
                start_day = 4
                set_start_date(item: expense_months_item, 
                               year: @current_year - 1, month: 7,
                               day: start_day)
                set_end_date(item: expense_months_item, 
                               year: @current_year, month: @current_month,
                               day: start_day + 1)
                expense_months_item.recur_period = 2 # months

                expect(expense_months_item.
                       first_instance_this_month).to eq(start_day)
              end
            end
          end
        end
      end

      context 'if it won\'t recur in the given month' do 
        it 'returns nil' do
          start_day = 31
          set_start_date(item: expense_months_item, year: @current_year, 
                         month: 1, day: start_day)
          expense_months_item.recur_period = 3 #months

          expect(expense_months_item.first_instance_this_month).to be_nil
        end
      end
    end

    context 'given an income item' do
      context 'if it would recur in the given month' do
        context 'if it doesn\'t have an end date' do 
          context 'if the current month is longer than its start day' do
            it 'returns its start_date\'s day' do
              start_day = 31
              set_start_date(item: income_months_item, year: @current_year,
                             month: 3, day: start_day) 
              income_months_item.recur_period = 2 #months

              expect(income_months_item.
                     first_instance_this_month).to eq(start_day)
            end
          end

          context 'if the current month is shorter than its start day' do
            it 'returns the last day of the current month' do
              travel_to DateTime.new(2021, 2, 13, 7, 30, 0) # february
              days_in_february = 28

              set_start_date(item: income_months_item, year: @current_year,
                             month: 1, day: 30)
              income_months_item.recur_period = 1 #month

              expect(income_months_item.
                     first_instance_this_month).to eq(days_in_february)
            end
          end
        end

        context 'if it has an end date' do
          context 'if the end date is before the current month' do
            it 'returns nil' do
              set_start_date(item: income_months_item, 
                             year: @current_year - 1, month: 1, 
                             day: 30)
              set_end_date(item: income_months_item, year: @current_year, 
                           month: 3, day: 31)
              income_months_item.recur_period = 1 #month

              expect(income_months_item.
                     first_instance_this_month).to be_nil
            end
          end

          context 'if the end date is in the current month' do
            context 'if the end date is before its start day' do
              it 'returns nil' do
                set_start_date(item: income_months_item, 
                               year: @current_year - 1, month: 7, day: 4)
                set_end_date(item: income_months_item, 
                             year: @current_year, month: @current_month,
                             day: 3)
                income_months_item.recur_period = 2 # months

                expect(income_months_item.
                       first_instance_this_month).to be_nil
              end
            end

            context 'if the end date is after its start day' do
              it 'returns its start day' do
                start_day = 4
                set_start_date(item: income_months_item, 
                               year: @current_year - 1, month: 7,
                               day: start_day)
                set_end_date(item: income_months_item, year: @current_year,
                             month: @current_month, day: 5)
                income_months_item.recur_period = 2 # months

                expect(income_months_item.
                       first_instance_this_month).to eq(start_day)
              end
            end
          end
        end
      end

      context 'if it won\'t recur in the given month' do 
        it 'returns nil' do
          start_day = 31
          set_start_date(item: income_months_item, year: @current_year,
                         month: 1, day: start_day)
          income_months_item.recur_period = 3 #months

          expect(income_months_item.first_instance_this_month).to be_nil
        end
      end
    end
  end
end


def set_start_date(item:, year:, month:, day:, **time)
  time[:hour] = time[:hour] || rand(24)
  time[:minute] = time[:minute] || rand(60)
  time[:second] = time[:second] || rand(60)

  date = DateTime.new(year, month, day, 
                      time[:hour], time[:minute], time[:second])
  item.start_date = date
end

def set_end_date(item:, year:, month:, day:, **time)
  time[:hour] = time[:hour] || rand(24)
  time[:minute] = time[:minute] || rand(60)
  time[:second] = time[:second] || rand(60)

  date = DateTime.new(year, month, day, 
                      time[:hour], time[:minute], time[:second])
  item.end_date = date
end