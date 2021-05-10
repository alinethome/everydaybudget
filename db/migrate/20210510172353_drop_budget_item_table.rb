class DropBudgetItemTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :budget_items do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :type, null: false
      t.boolean :is_recurring, default: false, null: false
      t.integer :recur_period
      t.datetime :date, null: false
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
      t.float :amount, null: false
      t.string :recur_unit
      t.datetime :end_date
      t.index :date
      t.index :type
      t.index :user_id
    end
  end
end
