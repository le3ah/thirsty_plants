class GardensController < ApplicationController
  before_action :require_garden_owner, only: [:edit, :update, :destroy]
  
  def new
    @garden = Garden.new
    3.times { @garden.plants.build }
  end

  def create
    @garden = Garden.new(garden_params)
    @garden.owners = [current_user]
    if @garden.save
      flash[:success] = "Party in My Plants! New Garden Successfully Created!"
      redirect_to garden_path(@garden)
    else
      @errors = @garden.errors
      render :new
    end
  end

  def show
    unless garden.users.include? current_user
      render_404
    end
  end

  def index
    @user = current_user
    @next_seven_days = next_seven_days
    @facade = GardenFacade.new(current_user)
  end

  def edit
    @garden = garden
  end

  def update
    garden.update(garden_params)
    if garden.save
      flash[:success] = 'Garden updated successfully!'
      redirect_to garden_path(garden)
    else
      @errors = garden.errors
      render :edit
    end
  end

  def destroy
    garden.destroy
    flash[:success] = "Garden successfully deleted."
    redirect_to dashboard_path
  end

  private
  
  def garden
    @garden ||= Garden.find(params[:id])
  end
  
  def garden_params
    params.require(:garden)
    .permit(:name, :zip_code, :plants,
      plants_attributes: [:name, :times_per_week])
  end

  def next_seven_days
    days = []
    i = 1
    7.times do
      days << (Time.now + i.days).strftime('%A')
      i += 1
    end
    days
  end
  
  def require_garden_owner
    render_404 unless current_user.own_gardens.include?(garden)
  end
end
