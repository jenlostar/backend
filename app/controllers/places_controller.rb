class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      flash[:success] = t('.the_new_place_has_been_created')
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
      flash[:success] = t('.the_new_place_has_been_updated')
      redirect_to edit_place_path(@place)
    else
      render 'edit'
    end
  end

 def place_params
    params.require(:place).permit(
      :name,
      :address,
      :instructions,
      :mobile_phone,
      :land_line)
  end
end
