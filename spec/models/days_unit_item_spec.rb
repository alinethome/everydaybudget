require 'rails_helper'

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
            previous_year = @current_year - 1
            date = DateTime.new(previous_year, 7, 3, 0, 0, 0) # July 3rd, 2021
            expense_days_item.recur_period = 18
            expense_days_item.start_date = date

            recur_day = 5
            expect(expense_days_item.first_instance_this_month).to eq(recur_day)
          end

          context 'that will recur the first of the month' do
            it 'returns 1' do
              date = DateTime.new(@current_year, 4, 29, 0, 0, 0) # April 29, 2021
              expense_days_item.recur_period = 2
              expense_days_item.start_date = date

              recur_day = 1
              expect(expense_days_item.first_instance_this_month).to eq(recur_day)
            end
          end
        end

        describe 'that will not recur in the current month' do
          it 'returns nil' do 
            date = DateTime.new(@current_year, 4, 17, 0, 0, 0) # April 17, 2020
            expense_days_item.recur_period = 60
            expense_days_item.start_date = date

            expect(expense_days_item.first_instance_this_month).to be_nil
          end
        end
      end

      describe 'with an end date before the current month' do
        it 'returns nil' do 
          previous_year = @current_year - 1
          date = DateTime.new(previous_year, 7, 3, 0, 0, 0) # July 3rd, 2021
          end_date = DateTime.new(@current_year, 
                                  4, 30, 0, 0) # April 30th, 2021
          expense_days_item.recur_period = 18
          expense_days_item.start_date = date
          expense_days_item.end_date = end_date

          expect(expense_days_item.first_instance_this_month).to be_nil
        end
      end

      describe 'with an end date in the current month' do
        describe 'if the end date falls before the first recur would occur' do
          it 'returns nil' do
            previous_year = @current_year - 1
            date = DateTime.new(previous_year, 7, 3, 0, 0, 0) # July 3rd, 2021
            end_date = DateTime.new(@current_year, 
                                    5, 1, 0, 0) # May 1st, 2021
            expense_days_item.recur_period = 18
            expense_days_item.start_date = date
            expense_days_item.end_date = end_date

            expect(expense_days_item.first_instance_this_month).to be_nil
          end
        end

        describe 'if the end date falls after the first recur would occur' do
          it 'returns the first recur of the month' do
            previous_year = @current_year - 1
            date = DateTime.new(previous_year, 7, 3, 0, 0, 0) # July 3rd, 2021
            end_date = DateTime.new(@current_year, 
                                    5, 6, 0, 0) # May 5th, 2021
            expense_days_item.recur_period = 18
            expense_days_item.start_date = date
            expense_days_item.end_date = end_date

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
            previous_year = @current_year - 1
            date = DateTime.new(previous_year, 7, 4, 0, 0, 0) # July 3rd, 2021
            income_days_item.recur_period = 18
            income_days_item.start_date = date

            recur_day = 6
            expect(income_days_item.first_instance_this_month).to eq(recur_day)
          end

          context 'that will recur the first of the month' do
            it 'returns 1' do
              date = DateTime.new(@current_year, 4, 30, 0, 0, 0) # April 29, 2021
              income_days_item.recur_period = 1
              income_days_item.start_date = date

              recur_day = 1
              expect(income_days_item.first_instance_this_month).to eq(recur_day)
            end
          end
        end

        describe 'that will not recur in the current month' do
          it 'returns nil' do 
            date = DateTime.new(@current_year, 4, 17, 0, 0, 0) # April 17, 2020
            income_days_item.recur_period = 100
            income_days_item.start_date = date

            expect(income_days_item.first_instance_this_month).to be_nil
          end
        end
      end

      describe 'with an end date before the current month' do
        it 'returns nil' do 
          previous_year = @current_year - 1
          date = DateTime.new(previous_year, 7, 3, 0, 0, 0) # July 3rd, 2021
          end_date = DateTime.new(@current_year, 
                                  4, 30, 0, 0) # April 30th, 2021
          income_days_item.recur_period = 18
          income_days_item.start_date = date
          income_days_item.end_date = end_date

          expect(income_days_item.first_instance_this_month).to be_nil
        end
      end

      describe 'with an end date in the current month' do
        describe 'if the end date falls before the first recur would occur' do
          it 'returns nil' do
            previous_year = @current_year - 1
            date = DateTime.new(previous_year, 7, 3, 0, 0, 0) # July 3rd, 2021
            end_date = DateTime.new(@current_year, 
                                    5, 1, 0, 0) # May 1st, 2021
            income_days_item.recur_period = 18
            income_days_item.start_date = date
            income_days_item.end_date = end_date

            expect(income_days_item.first_instance_this_month).to be_nil
          end
        end

        describe 'if the end date falls after the first recur would occur' do
          it 'returns the first recur of the month' do
            previous_year = @current_year - 1
            date = DateTime.new(previous_year, 7, 3, 0, 0, 0) # July 3rd, 2021
            end_date = DateTime.new(@current_year, 
                                    5, 6, 0, 0) # May 5th, 2021
            income_days_item.recur_period = 18
            income_days_item.start_date = date
            income_days_item.end_date = end_date

            recur_day = 5
            expect(income_days_item.
                   first_instance_this_month).to eq(recur_day)
          end
        end
      end
    end
  end
end

