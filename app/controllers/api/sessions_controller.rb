class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:password])

    if @user
      sign_in!(@user)
      render 'api/users/show'
    else
      render json: ["Wrong email/password combination"], status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
