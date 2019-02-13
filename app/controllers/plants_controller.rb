class PlantsController < ApplicationController
  
  def new
    @plant = Plant.new
  end
end