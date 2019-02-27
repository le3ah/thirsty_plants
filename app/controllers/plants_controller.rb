class PlantsController < ApplicationController
  before_action :require_garden_owner, only: [:edit, :update, :destroy]

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
    @plant = plant
  end

  def update
    plant.update(plant_params)
    if plant.save
      flash[:success] = 'Plant updated successfully!'
      plant.generate_waterings  
      redirect_to garden_path(plant.garden)
    else
      @errors = plant.errors
      render :edit
    end
  end

  def show
    @plant = plant
  end

  def destroy
    plant = Plant.find(params[:id])
    garden = plant.garden
    plant.destroy
    flash[:success] = 'Goodbye dear plant'
    redirect_to garden_path(garden)
  end

  private
  
  def plant
    @plant ||= Plant.find(params[:id])
  end

  def plant_params
    params.require(:plant).permit(:name, :times_per_week, :thumbnail)
  end
  
  def require_garden_owner
    render_404 unless current_user.own_gardens.include?(plant.garden)
  end
end
