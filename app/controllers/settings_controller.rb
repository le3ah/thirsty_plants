class SettingsController < ApplicationController
  def index
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(settings_params)
    redirect_to(settings_path)
  end

  def settings_params
    params.require(:user).permit(
           :recieve_email, :recieve_texts,
           :telephone,
           :rainy_day_notifications, :frost_notifications, :missed_watering_notifications)
  end
end
