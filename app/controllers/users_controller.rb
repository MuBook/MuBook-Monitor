class UsersController < ApplicationController

  skip_before_filter :login

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url
    else
      render :new
    end
  end

  def update
  end

private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :token)
  end

end
