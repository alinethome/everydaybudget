class DaysUnitItem < RecurringItem
  def first_instance_this_month
    # we call now here and pass it down to subsequent methods so answers
    # don't change between method calls if the clock ticks over into a
    # different month
    now = DateTime.now

    first_possible_instance = 1 + days_to_next_recur(now.month, now.year)

    if recurs_in_month?(first_possible_instance, now.month, now.year)
      first_possible_instance
    else
      nil
    end
  end

  private

  # all the days_to and days_since methods are calculated from the 
  # first of the month

  def days_to_next_recur(current_month, current_year)
    days_since_last_recur = days_since_last_recur(current_month, 
                                                  current_year)

    if (days_since_last_recur == 0)
      0
    else
      self.recur_period - days_since_last_recur(current_month, current_year)
    end
  end

  def days_since_last_recur(current_month, current_year)
    days = days_since_first_recur(current_month, current_year) % 
      self.recur_period
  end

  def days_since_first_recur(current_month, current_year)
    first_of_current_month = DateTime.new(current_year, current_month, 1, 0, 0, 0)
    days_between(self.start_date, first_of_current_month)
  end

  def days_between(date1, date2)
    # The conversion to datetime is here simply because of the tests
    # The time helpers in active support stub out DateTime.now 
    # with a Time object, and they need to be converted to be able to
    # subtract from a DateTime object
    #
    # We need to take the ceiling so we still get the correct number of
    # days even if the time of the latter date is earlier than the time of
    # the first date. 
    (date2.to_datetime - date1.to_datetime).ceil.to_i.abs
  end

  def recurs_in_month?(first_possible_recur, month, year)
    last_possible_recur = last_possible_recur_of_month(month, year)

    last_possible_recur && (first_possible_recur < last_possible_recur)
  end

  def last_possible_recur_of_month(month, year)
    if (self.end_date)
      return nil if !end_date_in_month?(month, year)
      self.end_date.day
    else 
      Time.days_in_month(month, year)
    end
  end

end
