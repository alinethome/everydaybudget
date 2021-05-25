json.extract! item, :id, :name, :type, 
  :start_date, :end_date, :recur_period,
  :recur_unit_type, :amount

json.month_instances item.instances_this_month

