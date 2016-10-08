class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :authenticate

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def authorize
    @user = User.find_by_id session[:uid]
  end

  def current_user
    @user
  end

  def authenticate?
    current_user && current_user.authenticate?
  end

  def authenticate
    redirect_to auth_path unless authenticate?
  end
end
