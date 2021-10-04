class RecurringItem < BudgetItem
  self.inheritance_column = :recur_unit_type

  validates :recur_unit_type, inclusion: { in: ["DaysUnitItem",
                                                "MonthsUnitItem"] }
  validates :start_date, :recur_period, :recur_unit_type, presence: true
  validates_numericality_of :recur_period, greater_than: 0 

  def first_instance_this_month
  end

  def instances_this_month
  end
end
