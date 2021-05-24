json.extract! item, :id, :user_id, :name, :type, 
  :start_date, :end_date, :amount

json.recur_unit do
  if item.recur_unit_type == "DaysUnitItem"
    "days"
  else
    "months"
  end
end

json.month_instances item.instances_this_month

