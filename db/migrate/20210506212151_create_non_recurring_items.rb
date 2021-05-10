class CreateNonRecurringItems < ActiveRecord::Migration[6.0]
  def change
    create_table :non_recurring_items do |t|
      t.integer :user_id, null: false, index: true
      t.string :name, null: false
      t.string :type, null: false, index: true
      t.datetime :date, null: false, index: true
      t.float :amount, null: false

      t.timestamps
    end
  end
end
