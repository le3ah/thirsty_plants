class InviteController < ApplicationController
  def show
  end

  def create
    CaretakerNotifierMailer.inform(current_user, params[:email]).deliver_now
    flash[:notice] = "Success! You invited a caretaker to watch your gardens."
    redirect_to dashboard_url
  end

end
