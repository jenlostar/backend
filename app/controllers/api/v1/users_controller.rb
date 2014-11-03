module API
  module V1
    class UsersController < API::V1::BaseController
      doorkeeper_for :all, except: [:login, :signup]

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
          :first_name,
          :last_name,
          :email,
          :gender,
          :phone_number,
          :password,
          :password_confirmation
        )
      end

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end

