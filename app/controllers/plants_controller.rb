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

  def edit
    @plant = Plant.find(params[:id])
  end

  def update
    @plant = Plant.find(params[:id])
    @plant.update(plant_params)
    if @plant.save
      flash[:success] = 'Plant updated successfully!'
      redirect_to garden_path(@plant.garden)
    else
      @errors = @plant.errors
      render :edit
    end
  end


  def destroy
    plant = Plant.find(params[:id])
    garden = plant.garden
    plant.destroy
    flash[:success] = 'Goodbye dear plant'
    redirect_to garden_path(garden)
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :times_per_week)
  end
end
