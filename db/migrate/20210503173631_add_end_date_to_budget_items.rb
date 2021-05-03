class AddEndDateToBudgetItems < ActiveRecord::Migration[6.0]
  def change
    add_column :budget_items, :end_date, :datetime
  end
end
