class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.page(params[:page])
  end

  def edit
  end

  def update
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

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

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
