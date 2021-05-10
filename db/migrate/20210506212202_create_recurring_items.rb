class CreateRecurringItems < ActiveRecord::Migration[6.0]
  def change
    create_table :recurring_items do |t|
      t.integer :user_id, null: false, index: true
      t.string :name, null: false
      t.string :type, null: false, index: true
      t.datetime :start_date, null: false, index: true
      t.datetime :end_date, index: true
      t.integer :recur_period, index: true
      t.string :recur_unit, null: false
      t.float :amount, null: false

      t.timestamps
    end
  end
end
