class ChangeRecurUnitFieldNameInRecurringItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :recurring_items, :recur_unit, :recur_unit_type 
  end
end
