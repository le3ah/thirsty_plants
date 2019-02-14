class Day
  def self.generate_days(args)
    days_ago = args[:days_ago] || 0
    days_from_now = args[:days_from_now] || 7
    user = args[:user]
    ((0 - days_ago) .. days_from_now).map do |i|
      Day.new(i.days.from_now, user)
    end
  end

  def initialize(date, user = nil)
    @date = date
    @user = user
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

  def small_date
    @date.strftime('%b. %d')
  end

  def waterings
    Watering.joins(plant: :garden)
            .where(water_time: @date.beginning_of_day ... (@date.beginning_of_day + 1.day))
            .where(plant: { gardens: { user_id: @user.id } } )
  end

end