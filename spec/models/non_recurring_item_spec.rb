require 'rails_helper'
require 'budget_item_spec_helper'

RSpec.describe NonRecurringItem, type: :model do
  let(:non_recurring_expense) { FactoryBot.build(:non_recurring_item, 
                                                 :expense)}
  let(:non_recurring_income) { FactoryBot.build(:non_recurring_item, :income) }

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:date) }
    it { should validate_inclusion_of(:type)
      .in_array(["income", "expense"])}
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

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

    context 'given an expense' do
      context 'from that month' do
        it 'returns the day it was incurred' do
          day = 3
          date = DateTime.new(@current_year,@current_month,day,3,2,1)
          non_recurring_expense.date = date

          expect(non_recurring_expense.first_instance_this_month).to eq(day)
        end
      end

      context 'from a previous month' do
        it 'returns nil' do
          previous_month = @current_month - 1
          date = DateTime.new(@current_year,previous_month,17,10,0,0)
          non_recurring_expense.date = date

          expect(non_recurring_expense.first_instance_this_month).to be_nil
        end
      end
    end

    context 'given an income item' do
      context 'from that month' do 
        it 'returns the day it was incurred' do
          day = 3
          date = DateTime.new(@current_year,@current_month,day,3,2,1)
          non_recurring_income.date = date

          expect(non_recurring_income.first_instance_this_month).to eq(day)
        end

        context 'from a previous month' do
          it 'returns nil' do 
            previous_month = @current_month - 1
            date = DateTime.new(@current_year,previous_month,17,10,0,0)
            non_recurring_income.date = date

            expect(non_recurring_income.first_instance_this_month).to be_nil
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
      describe 'with a date from the current month' do
        it 'returns an array containing the item\'s date day' do
          day = 24
          date = DateTime.new(@current_year,@current_month,day,3,2,1)
          non_recurring_expense.date = date

          expect(non_recurring_expense.instances_this_month).to eq([day])
        end
      end

      describe 'with a date from a past month' do
        it 'returns an empty array' do 
          day = 24
          previous_month = @current_month - 1
          date = DateTime.new(@current_year,previous_month,day,3,2,1)
          non_recurring_expense.date = date

          expect(non_recurring_expense.instances_this_month).to eq([])
        end
      end

      describe 'given an income item' do
        describe 'with a date from the current month' do
          it 'returns an array containing the item\'s date day' do
            day = 24
            date = DateTime.new(@current_year,@current_month,day,3,2,1)
            non_recurring_income.date = date

            expect(non_recurring_income.instances_this_month).to eq([day])
          end
        end

        describe 'with a date from a past month' do
          it 'returns an empty array' do
            day = 24
            previous_month = @current_month - 1
            date = DateTime.new(@current_year,previous_month,day,3,2,1)
            non_recurring_income.date = date

            expect(non_recurring_income.instances_this_month).to eq([])
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
      describe 'if it\'s from the current month' do
        it 'returns minus the item\'s amount' do
          set_date(item: non_recurring_expense, year: @current_year, 
                   month: @current_month, day: 1)
          amount = 250.3
          non_recurring_expense.amount = amount

          expect(non_recurring_expense.total_monthly_amount).to eq(-amount)
        end
      end

      describe 'if it\'s from a previous month' do
        it 'returns 0' do
          set_date(item: non_recurring_expense, year: @current_year - 1, 
                   month: @current_month, day: 1)
          non_recurring_expense.amount =  73

          expect(non_recurring_expense.total_monthly_amount).to eq(0)
        end
      end
    end

    describe 'given an income item' do
      describe 'if it\'s from the current month' do
        it 'returns the item\'s amount' do
          set_date(item: non_recurring_income, year: @current_year, 
                   month: @current_month, day: 1)
          amount = 3
          non_recurring_income.amount = amount

          expect(non_recurring_income.total_monthly_amount).to eq(amount)
        end
      end

      describe 'if it\'s from a previous month' do
        it 'returns 0' do
          set_date(item: non_recurring_income, year: @current_year - 1, 
                   month: 11, day: 1)
          non_recurring_income.amount =  1024.5

          expect(non_recurring_income.total_monthly_amount).to eq(0)
        end
      end
    end
  end
end
