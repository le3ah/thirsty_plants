class PlantsController < ApplicationController
  
  def new
    @garden = Garden.find(params[:garden_id])
    @plant = Plant.new
  end
  
  def create
    @garden = Garden.find(params[:garden_id])
    @plant = @garden.plants.new(plant_params)
    if @plant.save
      flash[:success] = "Party in my plants, you've created a new plant!"
      redirect_to garden_path(@garden)
    else
      @errors = @plant.errors
      render :new
    end
  end
  
  private
  
  def plant_params
    params.require(:plant).permit(:name, :times_per_week)
  end
end