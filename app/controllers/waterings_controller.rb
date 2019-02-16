class WateringsController < ApplicationController
  def update
    Watering.find(params[:id]).update(completed: completed?)
  end

  private

  def watering_update_params
    params.require(:watering).permit(:completed)
  end

  def completed?
    watering_update_params[:completed]
  end
end
