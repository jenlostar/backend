##
# Esta clase representa el controlador encargado de realizar las operaciones
# CRUD de un lugar
class PlacesController < ApplicationController
  def index
    @places = Place.page params[:page]
    @place = Place.where(id: params[:id]).first unless params[:id].blank?
    @schedules = @place.schedules.group_by(&:day_of_week) unless @place.nil?
    @services = @place.services.group_by(&:kind) unless @place.nil?
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
    @place = Place.find(params[:id])
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
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to places_path
  end

  private

  def place_params
    params.require(:place).permit(
      :name,
      :address,
      :description,
      :mobile_phone,
      :land_line
    )
  end
end
