require 'active_support/time' 

class BudgetItem < ApplicationRecord
  self.abstract_class = true

  validates :user_id, :name, :type, :amount, presence: true
  validates :type, inclusion: { in: ["income", "expense"] }

  belongs_to :user

  def first_instance_this_month
    raise NotImplementedError
  end

  def instances_this_month
    raise NotImplementedError
  end

  def total_monthly_amount
    instances_this_month = self.instances_this_month

    return 0 if instances_this_month.empty?

    if self.type == "expense"
      -self.amount * instances_this_month.length
    else
      self.amount * instances_this_month.length
    end
  end

  private 

  def same_month?(date)
    (self.date.month == date.month) && (self.date.year == date.year)
  end
end
