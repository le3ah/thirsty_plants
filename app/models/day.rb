class Day
  def self.generate_days(args)
    days_ago = args[:days_ago] || 0
    days_from_now = args[:days_from_now] || 7
    ((0 - days_ago) .. days_from_now).map do |i|
      Day.new(i.days.from_now)
    end
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
