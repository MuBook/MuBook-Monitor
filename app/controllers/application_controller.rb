class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :login

private

  def login
    redirect_to login_path unless current_user
  end

  def current_user
    warden.user
  end

  helper_method :current_user

  def warden
    env['warden']
  end
end
