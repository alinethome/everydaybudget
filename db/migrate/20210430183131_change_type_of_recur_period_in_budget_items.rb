class ChangeTypeOfRecurPeriodInBudgetItems < ActiveRecord::Migration[6.0]
  def change
    change_column :budget_items, :recur_period,
      :integer, using: 'recur_period::integer'
  end
end
