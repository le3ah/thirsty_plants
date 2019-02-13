class GardensController < ApplicationController

  def new
    @garden = Garden.new
    3.times { @garden.plants.build }
  end

  def create
    garden = current_user.gardens.create(garden_params)
    redirect_to garden_path(garden)
  end

  def show
    @garden = Garden.find(params[:id])
  end

  private
  def garden_params
    params.require(:garden)
    .permit(:name, :zip_code, :plants,
      plants_attributes: [:name, :times_per_week])
  end

end
