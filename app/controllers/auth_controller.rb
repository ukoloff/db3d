class AuthController < ApplicationController
  skip_before_action :authenticate

  def callback
    z = request.env['omniauth.auth'].as_json
    oauth = Oauth.where(z.slice *%w(provider uid)).first_or_initialize
    oauth.info = z
    oauth.user ||= User.find_by_id(session[:uid]) || User.create
    session[:uid] = oauth.user.id
    oauth.save
    redirect_to session[:a2] ? '/' : auth_path
  end

  def index
    session[:a2] = authenticate? ? nil : 1
  end
end
