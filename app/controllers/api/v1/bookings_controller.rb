module API
  module V1
    ##
    # Esta clase representa un punto de montaje en el api para generar
    # una reserva
    class BookingsController < API::V1::BaseController
      def create
        booking = Booking.new(booking_params.tap { |bp| bp.delete(:services) })

        Service.where(id: booking_params[:services]).each do |s|
          booking.booked_services.build(service_name: s.name)
        end

        if booking.save
          render json: booking.to_json(include: :booked_services), status: 200
        else
          render json: { errors: booking.errors }, status: 404
        end
      end

      private

      def booking_params
        params.permit(:place_id, :date, services: [])
      end
    end
  end
end
