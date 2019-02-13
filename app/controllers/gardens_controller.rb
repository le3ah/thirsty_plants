class GardensController < ApplicationController

  def new
    @garden = Garden.new
  end

  def create
    garden = current_user.gardens.create!(garden_params)
  end

  private
  def garden_params
    params.require(:garden).permit(:name, :zip_code, :plants)
  end
end
