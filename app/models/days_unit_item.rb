class DaysUnitItem < RecurringItem
  def first_instance_this_month
    now = DateTime.now
    lower_bound = possible_instances_lower_bound(now)
    upper_bound = possible_instances_upper_bound(now)

    return nil if upper_before_lower?(lower_bound, upper_bound)
    return nil if !recurs_in_period?(lower_bound, upper_bound)

    first_possible_instance(lower_bound)
  end

  private

  def possible_instances_lower_bound(now)
    [self.start_date, first_of_the_month(now)].max
  end

  def first_of_the_month(now)
    DateTime.new(now.year, now.month, 1, 0, 0, 0)
  end

  def possible_instances_upper_bound(now)
    if self.end_date
      [self.end_date, last_of_the_month(now)].min 
    else
      last_of_the_month(now)
    end
  end

  def last_of_the_month(now)
    DateTime.new(now.year, now.month, Time.days_in_month(now.month),
                 0, 0, 0)
  end

  def upper_before_lower?(lower_bound, upper_bound)
    # this test doesn't consider the case of upper_bound
    # having a year strictly higher than the lower_bound
    # or a month strictly higher than the lower_bound
    # because the lower bound is restricted to the current
    # month, and the upper bound cannot be be later than 
    # the current month
      upper_bound.year < lower_bound.year ||
        upper_bound.month < lower_bound.month || 
        upper_bound.day < lower_bound.day 
  end

  def recurs_in_period?(lower_bound, upper_bound)
    first_possible_instance(lower_bound) <= upper_bound.day
  end

  def days_to_next_possible_instance(lower_bound)
    return 0 if days_since_last_instance(lower_bound) == 0

    self.recur_period - days_since_last_instance(lower_bound)
  end
  
  def days_since_last_instance(lower_bound)
    days_between(self.start_date, lower_bound) % self.recur_period
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

  def first_possible_instance(lower_bound)
    lower_bound.day + days_to_next_possible_instance(lower_bound)
  end
end
