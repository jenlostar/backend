module API
  module V1
    ##
    # Esta clase representa un punto de montaje en el api para
    # enviar los lugares disponibles
    class PlacesController < API::V1::BaseController
      # doorkeeper_for :all
      before_action :set_place, only: [:show, :bookings]

      ##
      # Listado de lugares
      # GET /api/v1/places
      def index
        @places = Place.completed
      end

      ##
      # Un lugar en específico
      # GET /api/v1/places/:id
      def show
        render partial: 'place', locals: { place: @place }
      end

      ##
      # Reservas de un lugar
      # GET /api/v1/places/:id/bookings/:on_day
      def bookings
        date = Date.parse(place_params[:on_day])
        @bookings = @place.bookings.on_day(date)
      end

      private

      def set_place
        @place = Place.find(params[:id])
      end

      def place_params
        params.permit(:on_day)
      end
    end
  end
end
