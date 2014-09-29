class API::V1::PlacesController < Api::V1::BaseController
  def index
    places = Place.limit(10)
    render json: places, status: :ok
  end

  def show
    place = Place.find(params[:id])
    render json: place, status: :ok
  end
end
