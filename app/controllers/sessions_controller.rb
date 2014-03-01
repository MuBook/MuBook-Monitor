class SessionsController < ApplicationController

  skip_before_filter :login

  def new
    @user = User.new
    flash.now.alert = warden.message if warden.message.present?
  end

  def create
    warden.authenticate!
    redirect_to root_path, notice: "Logged in!"
  end

  def destroy
    warden.logout
    redirect_to login_path, notice: "Logged out!"
  end

end
