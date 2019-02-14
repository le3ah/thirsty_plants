class Day
  def self.generate_days(total, offset)

  end

  def initialize(date)
    @date = date
  end

  def month_name
    @date.strftime('%B')
  end

  def day_of_week_name
    @date.strftime('%A')
  end

  def css_classes
    class_names = 'row'
    class_names += ' today' if @date.today?
    class_names += ' past-day' if (@date + 1.day).past?
    class_names
  end

  def css_id
    @date.strftime('%b%d')
  end

end
