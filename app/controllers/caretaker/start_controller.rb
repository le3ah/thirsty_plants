class Caretaker::StartController < ApplicationController

  def new
    garden_id = params[:garden_id]
    UserGarden.create(user: current_user, garden_id: garden_id, relationship_type: 1)
    flash[:notice] = "Welcome to your friend's garden!"
    redirect_to garden_path(garden_id)
  end
end
