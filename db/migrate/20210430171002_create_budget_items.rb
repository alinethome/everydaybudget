class CreateBudgetItems < ActiveRecord::Migration[6.0]
  def change
    create_table :budget_items do |t|
      t.integer :user_id, null: false, index: true
      t.string :name, null: false
      t.string :type, null: false, index: true
      t.boolean :is_recurring, null: false, default: false
      t.string :recur_period, null: true
      t.datetime :date, null: false, index: true

      t.timestamps
    end
  end
end
