class UsersController < ApplicationController
  def show
    @user = current_user
    @chance_of_rain = WeatherService.new(@user.location)
  end
end
