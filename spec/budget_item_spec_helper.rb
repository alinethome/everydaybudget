def set_start_date(item:, year:, month:, day:, **time)
  time[:hour] = time[:hour] || rand(24)
  time[:minute] = time[:minute] || rand(60)
  time[:second] = time[:second] || rand(60)

  date = DateTime.new(year, month, day, 
                      time[:hour], time[:minute], time[:second])
  item.start_date = date
end

def set_end_date(item:, year:, month:, day:, **time)
  time[:hour] = time[:hour] || rand(24)
  time[:minute] = time[:minute] || rand(60)
  time[:second] = time[:second] || rand(60)

  date = DateTime.new(year, month, day, 
                      time[:hour], time[:minute], time[:second])
  item.end_date = date
end

def set_date(item:, year:, month:, day:, **time)
  time[:hour] = time[:hour] || rand(24)
  time[:minute] = time[:minute] || rand(60)
  time[:second] = time[:second] || rand(60)

  date = DateTime.new(year, month, day, 
                      time[:hour], time[:minute], time[:second])
  item.date = date
end
