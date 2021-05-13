class MonthsUnitItem < RecurringItem
  def first_instance_this_month
    # we call now here and pass it down to subsequent methods so answers
    # don't change between method calls if the clock ticks over into a
    # different month
    now = DateTime.now

    possible_recur_day = recur_day(now.month, now.year)

    if (recurs_in_month?(possible_recur_day, now.month, now.year))
      possible_recur_day
    else
      nil
    end
  end

  def instances_this_month
    if first_instance_this_month 
      [first_instance_this_month]
    else
      []
    end
  end

  private 

  def recur_day(current_month, current_year)
    [self.start_date.day, Time.days_in_month(current_month)].min
  end

  def months_from_start_date(current_month, current_year)
    if (self.start_date.month < current_month)
      current_month - self.start_date.month + 
        12 * (current_year - self.start_date.year)
    else
      (current_month - self.start_date.month) % 12 + 
        12 * (current_year - self.start_date.year - 1)
    end
  end

  def recurs_in_month?(recur_day, month, year)
    month_matches_recur_period?(month, year) && (!self.end_date || 
      end_date_after_recur_day?(month, year, recur_day))
  end

  def month_matches_recur_period?(month, year)
    months_from_start_date(month, year) % self.recur_period == 0
  end

  def end_date_after_recur_day?(month, year, recur_day)
    end_date_in_month?(month, year) &&
      end_date_day_after_recur_day?(recur_day)
  end

  def end_date_day_after_recur_day?(recur_day)
    self.end_date.day > recur_day
  end

  def end_date_in_month?(month, year)
    self.end_date.month == month && self.end_date.year == year
  end

  def start_date_in_month?(month, year)
    self.start_date.month == month && self.start_date.year == year
  end
end
