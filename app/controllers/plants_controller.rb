class PlantsController < ApplicationController
  
  def new
    @garden = Garden.find(params[:garden_id])
    @plant = Plant.new
  end
  
  def create
    garden = Garden.find(params[:garden_id])
    garden.plants.create(plant_params)
    flash[:success] = "Party in my plants, you've created a new plant!"
    redirect_to garden_path(garden)
  end
  
  private
  
  def plant_params
    params.require(:plant).permit(:name, :times_per_week)
  end
end