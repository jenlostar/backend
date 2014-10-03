class API::V1::BookingsController < Api::V1::BaseController
  def create
    booking = Booking.new(booking_params.tap { |bp| bp.delete(:services) })

    if booking.save
      services = Service.find(booking_params[:services])

      services.each do |s|
        booking.booked_services.create do |bs|
          bs.service_name = s.name
        end
      end

      render json: booking.to_json(:include => :booked_services), status: :ok
    else
      render json: booking.errors, status: 404
    end
  end

  private
  def booking_params
    params.permit(:place_id, :date, :services => [])
  end
end
