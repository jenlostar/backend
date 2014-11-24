class SessionsController < Devise::SessionsController
  def new
    redirect_to new_user_password_path
  end

  def create
    redirect_to new_user_password_path
  end
end
