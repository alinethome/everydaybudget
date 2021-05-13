class RecurringItem < BudgetItem
  self.inheritance_column = :recur_unit_type

  validates :recur_unit_type, inclusion: { in: ["DaysUnitItem",
                                                "MonthsUnitItem"] }
  validates :start_date, :recur_period, :recur_unit_type, presence: true

  def first_instance_this_month
  end

  def instances_this_month
  end

  private

  def end_date_in_month?(month, year)
    self.end_date.month == month && self.end_date.year == year
  end

  def start_date_in_month?(month, year)
    self.start_date.month == month && self.start_date.year == year
  end
end
