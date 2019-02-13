class PlantsController < ApplicationController
  
  def new
    @garden = Garden.find(params[:garden_id])
    @plant = Plant.new
  end
  
  def create
    garden = Garden.find(params[:garden_id])
    
    flash[:success] = "Party in my plants, you've created a new plant!"
    redirect_to garden_path(garden)
  end
end