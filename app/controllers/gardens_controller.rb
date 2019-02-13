class GardensController < ApplicationController

  def new
    @garden = Garden.new
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
    params.require(:garden).permit(:name, :zip_code, :plants)
  end
end
