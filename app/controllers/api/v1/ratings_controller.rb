module API
  module V1
    ##
    # Esta clase representa un punto de montaje en el api para guardar la
    # calificación de un lugar
    class RatingsController < API::V1::BaseController
      doorkeeper_for :all

      def create
        new_params = rating_params.tap { |rp| rp.delete(:value) }
        rating = Rating.where(new_params).first_or_initialize
        rating.value = rating_params[:value]

        if rating.save
          avg_value = Rating.for_place(new_params[:place_id]).first[1].to_f

          place = Place.find(new_params[:place_id])
          place.update_attribute(:rating_average, avg_value)

          response = rating.attributes.merge(place_rating_avg: avg_value)

          render json: response.to_json, status: 200
        else
          render json: { errors: rating.errors }, status: 404
        end
      end

      private

      def rating_params
        params.permit(:place_id, :user_id, :value)
      end
    end
  end
end
