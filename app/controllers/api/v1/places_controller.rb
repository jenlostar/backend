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
        date = Date.parse(place_params[:on_day]).beginning_of_day

        starts = date.advance(:hours => 7).to_i
        ends = date.advance(:hours => 19).to_i

        hours = (starts..ends).step(1.hour).map do |time|
          OpenStruct.new(date: Time.at(time), available: true, booking_id: nil)
        end

        bookings_on_day = @place.bookings.on_day(date)

        @bookings = hours.map do |time|
          booking = bookings_on_day.detect {|b| b.date ==  time.date}

          unless booking.nil?
            time.available = false
            time.booking_id = booking.id
          end

          time
        end
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
