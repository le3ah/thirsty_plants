class InviteController < ApplicationController
  def show
    @garden = Garden.find(params[:garden_id])
  end

  def create
    garden = Garden.find(params[:garden_id])
    CaretakerNotifierMailer.inform(current_user, params[:email], garden).deliver_now
    flash[:success] = "Success! You invited a caretaker to watch your gardens."
    redirect_to dashboard_url
  end

end
