require 'rails_helper'

RSpec.describe Budget, type: :model do
  describe '#initialize' do
    it 'takes an array of recurring items and one of non-recurring' do
      expect(Budget.new(recurring_items: [],
                        non_recurring_items: [])).to be_a(Budget)
    end

    context 'given no recurring items' do
      it 'raises an error' do
        expect { 
          Budget.new(non_recurring_items: []) 
        }.to raise_error(ArgumentError)
      end
    end

    context 'given no non-recurring items' do
      it 'raises an error' do
        expect { 
          Budget.new(recurring_items: []) 
        }.to raise_error(ArgumentError)
      end
    end
  end

  before do 
    @may = 5
    @current_year = 2021
    @today_18 = 18
    @DAYS_IN_MAY = Time.days_in_month(5, 2021)

    travel_to DateTime.new(@current_year, @may, @today_18, 0, 0, 0)
  end

  after do
    travel_back
  end

  let(:monthly_income) { double('MonthsUnitItem', {
    total_monthly_amount: 310
  }) }

  let(:monthly_expense) { double('MonthsUnitItem', {
    total_monthly_amount: -155
  }) }

  let(:single_expense_today) { 
    double('NonRecurringItem', {
      total_monthly_amount: -31,
      instances_this_month: [@today_18]
    }) }

  let(:single_expense_yesterday) { 
    double('NonRecurringItem', {
      total_monthly_amount: -31,
      instances_this_month: [@today_18 - 1]
    }) }

  describe '#max_daily_budget' do
    it 'it returns the amount the user has to spend that day' do
      balance = monthly_income.total_monthly_amount +
        monthly_expense.total_monthly_amount + 
        single_expense_yesterday.total_monthly_amount

      budget = Budget.new(recurring_items: [monthly_income, monthly_expense],
                          non_recurring_items: [
                            single_expense_today, 
                            single_expense_yesterday
                          ])

      expect(budget.max_daily_budget).to eq(balance/@DAYS_IN_MAY)
    end

    context 'initialised with one recurring income item' do
      context 'and initialised with nothing else' do
        it 'returns the item\'s monthly amount divided by the month\'s days' do
          budget = Budget.new(recurring_items: [monthly_income],
                              non_recurring_items: [])

          expect(budget.
                 max_daily_budget).to eq(monthly_income.
                                         total_monthly_amount/@DAYS_IN_MAY)
        end
      end

      context 'and initialised with a non-recurring expense on that day' do
        it 'returns the monthly income over the month\'s days' do
          budget = Budget.new(recurring_items: [monthly_income],
                              non_recurring_items: [single_expense_today])

          expect(budget.
                 max_daily_budget).to eq(monthly_income.
                                         total_monthly_amount/@DAYS_IN_MAY)
        end
      end

      context 'and initialised with a non-recurring expense the day before' do
        it 'returns the total balance over the month\'s days'do
          balance = monthly_income.total_monthly_amount +
            single_expense_yesterday.total_monthly_amount

          budget = Budget.new(recurring_items: [monthly_income],
                              non_recurring_items: [single_expense_yesterday])

          expect(budget.max_daily_budget).to eq(balance/@DAYS_IN_MAY)
        end
      end
    end
  end

  describe '#remaining_daily_budget' do
    it 'returns the remaining amount to spend on that day' do
      max_daily = (monthly_income.total_monthly_amount +
                   monthly_expense.total_monthly_amount + 
                   single_expense_yesterday.total_monthly_amount) / @DAYS_IN_MAY
      daily_expense = -single_expense_today.total_monthly_amount

      budget = Budget.new(recurring_items: [monthly_income, monthly_expense],
                          non_recurring_items: [
                            single_expense_today, 
                            single_expense_yesterday
                          ])

      expect(budget.
             remaining_daily_budget).to eq(max_daily - daily_expense)
    end

    context 'given a budget with no non-recurring items' do
      it 'returns the max daily budget' do
        max_daily = (monthly_income.total_monthly_amount +
                     monthly_expense.total_monthly_amount) / @DAYS_IN_MAY

        budget = Budget.new(recurring_items: [monthly_income, monthly_expense],
                            non_recurring_items: [])

        expect(budget.remaining_daily_budget).to eq(max_daily)
      end
    end

    context 'given a budget with an expense' do
      context 'if the expense was incurred that day' do
        it 'returns the max daily budget minus that expense' do
          max_daily = (monthly_income.total_monthly_amount) / @DAYS_IN_MAY
          expense_amount = -single_expense_today.total_monthly_amount

          budget = Budget.new(recurring_items: [monthly_income],
                              non_recurring_items: [single_expense_today])

          expect(budget.
                 remaining_daily_budget).to eq(max_daily - expense_amount)
        end
      end

      context 'if the expense was incurred on a previous day' do
        it 'returns the max daily budget ' do
          max_daily = (monthly_income.total_monthly_amount +
                       single_expense_yesterday.total_monthly_amount) /
                      @DAYS_IN_MAY

          budget = Budget.new(recurring_items: [monthly_income],
                              non_recurring_items: [single_expense_yesterday])

          expect(budget.remaining_daily_budget).to eq(max_daily)
        end
      end
    end
  end
end
