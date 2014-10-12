module API
  module V1
    ##
    # Esta clase representa un punto de montaje en el api para
    # enviar los lugares disponibles
    class PlacesController < API::V1::BaseController
      def index
        places = Place.joined
        includes = [:schedules, :services]
        render json: places.to_json(include: includes), status: 200
      end

      def show
        place = Place.find(params[:id])
        render json: place, status: 200
      end
    end
  end
end
