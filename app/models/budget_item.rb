class BudgetItem < ApplicationRecord
  validates :user_id, :name, :type, :is_recurring, :amount, :date, presence: true
  validates :recur_unit, inclusion: { in: ["days", "weeks", "months"] }
end
