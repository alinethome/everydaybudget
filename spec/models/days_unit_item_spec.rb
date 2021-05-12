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
end
