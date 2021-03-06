module API
  module V1
    ##
    # Esta clase representa un punto de montaje en el api para generar
    # una reserva
    class BookingsController < API::V1::BaseController
      doorkeeper_for :all

      def create
        booking = Booking.new_with_params(booking_params)

        if booking.save
          render json: booking.to_json(include: :booked_services), status: 200
        else
          render json: { errors: booking.errors }, status: 404
        end
      end

      def index
        @user = current_resource_owner

        included_relations = [:place, :user, :booked_services]
        @pending = @user.bookings.includes(*included_relations)

        render json: bookings.to_json(*included_relations), status: 200
      end

      private

      def booking_params
        params.permit(:place_id, :user_id, :date, services: [])
      end
    end
  end
end
