class Caretaker::StopController < ApplicationController

  def destroy
    garden = Garden.find(params[:garden_id])
    UserGarden.find_by(garden_id: garden, user: current_user).destroy
    flash[:success] = "You are no longer taking care of #{garden.name}"
    redirect_to gardens_path
  end
end
