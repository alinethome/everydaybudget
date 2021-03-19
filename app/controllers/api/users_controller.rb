class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params) 

    if @user.save
      render :show
    else
      render json: @user.errors.full_messages, status: 422
    end
  end
  
  def destroy
    @user = selected_user

    if @user
      @user.destroy
      render :show
    else
      render json: ['The user could not be found']
    end
  end

  private

  def selected_user
    User.find_by(id: params[:id])
  end

  def user_params 
    params.require(:user).permit(:email, :password)
  end
end
