module API
  module V1
    ##
    # Esta clase representa un punto de montaje en el api para
    # enviar los lugares disponibles
    class PlacesController < API::V1::BaseController
      ##
      # Listado de lugares
      # GET /api/v1/places
      def index
        @places = Place.limit(10)
      end

      ##
      # Un lugar en específico
      # GET /api/v1/places/:id
      def show
        place = Place.find(params[:id])
        render json: place, status: 200
      end
    end
  end
end
