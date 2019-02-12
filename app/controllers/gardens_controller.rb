class GardensController < ApplicationController

  def new
    @garden = Garden.new
  end
end
