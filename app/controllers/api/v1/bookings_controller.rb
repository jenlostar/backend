module API
  module V1
    ##
    # Esta clase representa un punto de montaje en el api para generar
    # una reserva
    class BookingsController < API::V1::BaseController
      def create
        booking = Booking.new_with_params(booking_params)

        if booking.save
          render json: booking.to_json(include: :booked_services), status: 200
        else
          render json: { errors: booking.errors }, status: 404
        end
      end

      private

      def booking_params
        params.permit(:place_id, :user_id, :date, services: [])
      end
    end
  end
end
