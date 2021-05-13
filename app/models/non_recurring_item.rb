class NonRecurringItem < BudgetItem
  validates :date, presence: true
  
  def first_instance_this_month
    now = DateTime.now

    return nil if (!same_month?(now))
    self.date.day
  end

  def instances_this_month
    first = first_instance_this_month 

    if first 
      [first]
    else
      []
    end
  end
end
