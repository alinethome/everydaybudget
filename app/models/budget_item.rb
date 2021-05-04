class BudgetItem < ApplicationRecord
  validates :user_id, :name, :type, :is_recurring, :amount, :date, presence: true
  validates :type, inclusion: { in: ["income", "expense"] }

  belongs_to :user
end
