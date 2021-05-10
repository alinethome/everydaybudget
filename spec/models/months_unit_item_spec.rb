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
              start_date = DateTime.new(@current_year, 3, start_day,
                                        3, 33, 0) # March 31, 2021
              expense_months_item.start_date = start_date
              expense_months_item.recur_period = 2 #months

              expect(expense_months_item.
                     first_instance_this_month).to eq(start_day)
            end
          end

          context 'if the current month is shorter than its start day' do
            it 'returns the last day of the current month' do
              travel_to DateTime.new(2021, 2, 13, 7, 30, 0) # february

              start_date = DateTime.new(@current_year, 1, 30,
                                  3, 33, 0) # January 30th, 2021
              expense_months_item.start_date = start_date
              expense_months_item.recur_period = 1 #month

              expect(expense_months_item.
                     first_instance_this_month).to eq(28)
            end
          end
        end

        context 'if it has an end date' do
          context 'if the end date is before the current month' do
            it 'returns nil' do
              travel_to DateTime.new(2021, 2, 13, 7, 30, 0) # february

              start_date = DateTime.new(@current_year - 1, 1, 30,
                                  3, 33, 0) # January 30th, 2020
              end_date = DateTime.new(@current_year, 3, 1,
                                     10, 43, 14) # March 1st, 2021
              expense_months_item.start_date = start_date
              expense_months_item.end_date = end_date
              expense_months_item.recur_period = 1 #month

              expect(expense_months_item.
                     first_instance_this_month).to be_nil
            end
          end

          context 'if the end date is in the current month' do
            context 'if the end date is before its start day' do
              it 'returns nil' do
                start_date = DateTime.new(@current_year - 1, 7, 4,
                                          14, 0, 0) # July 4th, 2020
                end_date = DateTime.new(@current_year, @current_month, 3, 
                                        3, 0, 0) # May 3rd, 2021
                expense_months_item.recur_period = 2 # months
                expense_months_item.start_date = start_date 
                expense_months_item.end_date = end_date 

                expect(expense_months_item.
                       first_instance_this_month).to be_nil
              end
            end

            context 'if the end date is after it\'s start day' do
              it 'returns its start day' do
                start_day = 4
                start_date = DateTime.new(@current_year - 1, 7, start_day,
                                          14, 0, 0) # July 4th, 2020
                end_date = DateTime.new(@current_year, @current_month, 5, 
                                        3, 0, 0) # May 5rd, 2021
                expense_months_item.recur_period = 2 # months
                expense_months_item.start_date = start_date 
                expense_months_item.end_date = end_date 

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
          start_date = DateTime.new(@current_year, 1, start_day,
                                    3, 33, 0) # January 31, 2021
          expense_months_item.start_date = start_date
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
              start_date = DateTime.new(@current_year, 3, start_day,
                                        3, 33, 0) # March 31, 2021
              income_months_item.start_date = start_date
              income_months_item.recur_period = 2 #months

              expect(income_months_item.
                     first_instance_this_month).to eq(31)
            end
          end

          context 'if the current month is shorter than its start day' do
            it 'returns the last day of the current month' do
              travel_to DateTime.new(2021, 2, 13, 7, 30, 0) # february

              start_date = DateTime.new(@current_year, 1, 30,
                                  3, 33, 0) # January 30th, 2021
              income_months_item.start_date = start_date
              income_months_item.recur_period = 1 #month

              expect(income_months_item.
                     first_instance_this_month).to eq(28)
            end
          end
        end

        context 'if it has an end date' do
          context 'if the end date is before the current month' do
            it 'returns nil' do
              travel_to DateTime.new(2021, 2, 13, 7, 30, 0) # february

              start_date = DateTime.new(@current_year - 1, 1, 30,
                                  3, 33, 0) # January 30th, 2020
              end_date = DateTime.new(@current_year, 3, 1,
                                     10, 43, 14) # March 1st, 2021
              income_months_item.start_date = start_date
              income_months_item.end_date = end_date
              income_months_item.recur_period = 1 #month

              expect(income_months_item.
                     first_instance_this_month).to be_nil
            end
          end

          context 'if the end date is in the current month' do
            context 'if the end date is before its start day' do
              it 'returns nil' do
                start_date = DateTime.new(@current_year - 1, 7, 4,
                                          14, 0, 0) # July 4th, 2020
                end_date = DateTime.new(@current_year, @current_month, 3, 
                                        3, 0, 0) # May 3rd, 2021
                income_months_item.recur_period = 2 # months
                income_months_item.start_date = start_date 
                income_months_item.end_date = end_date 

                expect(income_months_item.
                       first_instance_this_month).to be_nil
              end
            end

            context 'if the end date is after it\'s start day' do
              it 'returns its start day' do
                start_day = 4
                start_date = DateTime.new(@current_year - 1, 7, start_day,
                                          14, 0, 0) # July 4th, 2020
                end_date = DateTime.new(@current_year, @current_month, 5, 
                                        3, 0, 0) # May 5rd, 2021
                income_months_item.recur_period = 2 # months
                income_months_item.start_date = start_date 
                income_months_item.end_date = end_date 

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
          start_date = DateTime.new(@current_year, 1, start_day,
                                    3, 33, 0) # January 31, 2021
          income_months_item.start_date = start_date
          income_months_item.recur_period = 3 #months

          expect(income_months_item.first_instance_this_month).to be_nil
        end
      end
    end
  end
end

