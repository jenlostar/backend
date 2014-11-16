module API
  module V1

    BookingStruct = Struct.new(:date, :available, :booking_id, :duration)

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

        starts = date.advance(hours: 7).to_i
        ends = date.advance(hours: 19).to_i

        bookings_on_day = @place.bookings.on_day(date)


        @bookings = (starts..ends).step(1.hour).to_a.map do |time|
          BookingStruct.new(Time.at(time), true)
        end

        @bookings.each_with_index do |time, index|
          booking = bookings_on_day.detect {|b| b.date ==  time.date}
          services = booking.booked_services rescue nil
          duration = DateTime.parse(services.sum(:service_duration)) if services

          unless booking.nil?
            mark_booking_unavailable(booking, duration, index)
            if duration.hour > 0 && duration.min > 0
              mark_booking_unavailable(booking, duration, index+1)
              next
            end
          end
        end
      end

      private

      def set_place
        @place = Place.find(params[:id])
      end

      def place_params
        params.permit(:on_day)
      end

      def mark_booking_unavailable(booking, duration, index)
        return if index > @bookings.length

        @bookings[index].available = false
        @bookings[index].booking_id = booking.id
        @bookings[index].duration = duration
      end
    end
  end
end
