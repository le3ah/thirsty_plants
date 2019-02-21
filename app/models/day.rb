class Day
  def self.generate_days(args)
    days_ago = args[:days_ago] || 0
    days_from_now = args[:days_from_now] || 7
    user = args[:user]
    ((0 - days_ago) .. days_from_now).map do |i|
      Day.new(Date.parse(i.days.from_now.localtime.to_s), user)
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
    class_names += ' past-day' if (@date.end_of_day < Time.now)
    class_names += ' future-day' if (@date.beginning_of_day > Time.now)
    class_names
  end

  def css_name
    @date.strftime('%b%d')
  end

  def css_id
    'today' if @date.day == Time.now.day
  end

  def small_date
    @date.strftime('%b. %d')
  end

  def waterings
    Watering.joins(plant: {garden: :user_gardens})
            .where(water_time: @date)
            .where(plant: { garden: { user_gardens: {user: @user} } } )
  end

  def waterings?
    waterings.any?
  end

  def check_box_type
    if @date.day == Time.now.day
      "enabled-checkbox"
    else
      "disabled-checkbox"
    end
  end

end
