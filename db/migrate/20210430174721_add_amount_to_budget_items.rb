class AddAmountToBudgetItems < ActiveRecord::Migration[6.0]
  def change
    add_column :budget_items, :amount, :float, null: false
  end
end
