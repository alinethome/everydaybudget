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

  private 

  def same_month?(date)
    (self.date.month == date.month) && (self.date.year == date.year)
  end
end
