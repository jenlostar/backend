module API
  module V1
    class UsersController < API::V1::BaseController
      doorkeeper_for :all, except: [:login, :signup]

      def update
          @user = current_resource_owner
          @user.email = signup_params[:email]
          @user.first_name = signup_params[:first_name]
          @user.last_name = signup_params[:last_name]
          @user.phone_number = signup_params[:phone_number]
          @user.gender = signup_params[:gender]

          unless signup_params[:password].blank?
            @user.password = signup_params[:password]
          end
          unless signup_params[:password_confirmation].blank?
            @user.password_confirmation = signup_params[:password_confirmation]
          end

          unless @user.save
            render json: { errors: @user.errors }, status: 404
          end
      end

      def login
        @user = User.find_for_database_authentication(email: login_params[:email])
        unless @user && @user.valid_password?(login_params[:password])
          render json: { errors: 'Usuario / Contraseña inválidos' }, status: 404
        end
      end

      def logout
        doorkeeper_token.revoke
        render json: {}, status: 200
      end

      def signup
        @user = User.new(signup_params)
        unless @user.save
          render json: { errors: @user.errors }, status: 404
        end
      end

      private

      def signup_params
        params.permit(
          :email,
          :password,
          :password_confirmation,
          :first_name,
          :last_name,
          :gender,
          :phone_number
        )
      end

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end

