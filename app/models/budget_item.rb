class BudgetItem < ApplicationRecord
  validates :user_id, :name, :type, :is_recurring, :amount, :date, presence: true
  validates :recur_unit, inclusion: { in: ["days", "months"] }
  validates :type, inclusion: { in: ["income", "expense"] }

  belongs_to :user

  def first_instance_this_month
    now = DateTime.now

    return nil if (!self.is_recurring && !same_month?(now))
    return self.date.day if (!self.is_recurring && same_month?(now))

    first_instance_this_month = nil

    if (self.recur_unit == "days")
      first_instance_this_month = first_instance_days(now.month, now.year)
    else
      first_instance_this_month = first_instance_months(now.month, now.year)
    end

    return nil if (self.end_date && 
                   self.end_date.day < first_instance_this_month)
    first_instance_this_month
  end

  private 

  def same_month?(date)
    (self.date.month == date.month) && (self.date.year == date.year)
  end

  def first_instance_days(current_month, current_year)
    days_to_next_recur = days_to_next_recur(current_month, current_year)

    if (1 + days_to_next_recur > Time.days_in_month(current_month))
      nil
    else
      # the one is added because we're counting from the first of the
      # month
      1 + days_to_next_recur
    end
  end

  def days_to_next_recur(current_month, current_year)
    self.recur_period - days_since_last_recur(current_month, current_year)
  end

  def days_since_last_recur(current_month, current_year)
    days_since_first_recur(current_month, current_year) % self.recur_period
  end

  def days_since_first_recur(current_month, current_year)
    first_of_current_month = DateTime.new(current_year, current_month, 1, 0, 0, 0)
    days_between(self.date, first_of_current_month)
  end

  def days_between(date1, date2)
    # The coercion to datetime is here simply because of the tests
    # The time helpers in active support stub out DateTime.now 
    # with a Time object, and they need to be converted to be able to
    # subtract from a DateTime object
    #
    # We need to take the ceiling so we still get the correct number of
    # days even if the time of the latter date is earlier than the time of
    # the first date. 
    (date2.to_datetime - date1.to_datetime).ceil.to_i.abs
  end

  def first_instance_months(current_month, current_year)
    months = months_from_start_date(current_month, current_year)

    if (months % self.recur_period == 0)
      days_in_current_month = Time.days_in_month(current_month)

      if (self.date.day > days_in_current_month) 
        days_in_current_month
      else
        self.date.day
      end
    else
      nil
    end
  end

  def months_from_start_date(current_month, current_year)
    if (self.date.month < current_month)
      current_month - self.date.month + 12 * (current_year - self.date.year)
    else
      (current_month - self.date.month) % 12 + 
        12 * (current_year - self.date.year - 1)
    end
  end
end
