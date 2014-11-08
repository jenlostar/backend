##
# Esta clase representa el controlador encargado de realizar las operaciones
# CRUD de un lugar
class PlacesController < ApplicationController
  before_action :set_place, only: [:edit, :destroy]

  def index
    @places = Place.page params[:page]
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      flash[:success] = t(:place_created)
      redirect_to edit_place_path(@place)
    else
      render action: 'new'
    end
  end

  def edit
    @schedules = @place.schedules.group_by(&:day_of_week)
    @services = @place.services.group_by(&:kind)
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      flash[:success] = t(:place_updated)
      redirect_to edit_place_path(@place)
    else
      render 'edit'
    end
  end

  def destroy
    @place.destroy
    redirect_to places_path
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(
      :name,
      :address,
      :description,
      :mobile_phone,
      :land_line,
      :photo1,
      :photo2,
      :photo3
    )
  end
end
