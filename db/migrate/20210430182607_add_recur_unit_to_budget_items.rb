class AddRecurUnitToBudgetItems < ActiveRecord::Migration[6.0]
  def change
    add_column :budget_items, :recur_unit, :string
  end
end
