class NonRecurringItem < BudgetItem
  validates :date, presence: true
  
  def first_instance_this_month
    now = DateTime.now

    return nil if (!same_month?(now))
    self.date.day
  end
end
