class WeatherDay
  attr_reader :time,
              :precip_probability
              
  def initialize(attributes)
    @time = attributes[:time]
    @precip_probability = attributes[:precipProbability]
  end
end