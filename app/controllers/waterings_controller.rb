class WateringsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    watering = Watering.find(params[:id])
    watering.update(watering_update_params)
  end

  private

  def watering_update_params
    params.require(:watering).permit(:completed, :water_time)
  end
end
