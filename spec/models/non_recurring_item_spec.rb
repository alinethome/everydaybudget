require 'rails_helper'

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
end
