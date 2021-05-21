class Budget
  def initialize(recurring_items:, non_recurring_items:)
    @recurring_items = recurring_items
    @non_recurring_items = non_recurring_items
  end

  def max_daily_budget
    days = Time.days_in_month(now.month, now.year)

    @max_daily ||= total_balance/days
  end

  def remaining_daily_budget
    @remaining_daily = self.max_daily_budget + days_balance
  end

  private

  def total_balance
    recurring_balance + non_recurring_balance
  end

  def recurring_balance
    balance(@recurring_items)
  end

  def days_balance
    bal = @non_recurring_items.
      select { |item| item.instances_this_month.include?(now.day) }.
      inject(0) { |bal, item| bal + item.total_monthly_amount }
  end

  def non_recurring_balance
    previous_days_items = @non_recurring_items.
      select { |item| !item.instances_this_month.include?(now.day) }

    balance(previous_days_items)
  end

  def balance(item_list)
    item_list.inject(0) do |bal, item|
      bal + item.total_monthly_amount
    end
  end

  def now
    DateTime.now
  end
end
