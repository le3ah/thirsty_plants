class SettingsController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(settings_params)
      flash[:success] = "Settings Saved."
      redirect_to settings_path
    else
      @errors = @user.errors
      render :edit
    end
  end

  def settings_params
    params.require(:user).permit(
           :receives_emails, :receives_texts,
           :telephone,
           :rainy_day_notifications, :frost_notifications, :missed_watering_notifications)
  end
end
