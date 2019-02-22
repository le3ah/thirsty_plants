class Owner::Caretaker::StopController < ApplicationController

  def destroy
    garden = Garden.find(params[:garden_id])
    caretaker = User.find(params[:caretaker_id])
    UserGarden.find_by(garden_id: garden, user: caretaker).destroy
    flash[:success] = "#{caretaker.first_name} is no longer taking care of #{garden.name}"
    redirect_to gardens_path
  end
end
