class UsersController < ApplicationController
  def index
    @users = User.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    user_params_update = user_params

    if user_params_update[:password].blank?
      user_params_update.delete('password')
      user_params_update.delete('password_confirmation')
    end

    if @user.update(user_params_update)
      flash[:success] = t(:user_updated)
      redirect_to edit_user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :gender,
      :phone_number
    )
  end
end
