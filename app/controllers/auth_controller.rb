class AuthController < ApplicationController
  skip_before_action :authenticate

  def callback
    z = request.env['omniauth.auth'].as_json
    oauth = Oauth.where(z.slice *%w(provider uid)).first_or_initialize
    oauth.info = z
    oauth.user ||= current_user || User.create
    session[:uid] = oauth.user.id
    oauth.save
    redirect_to session[:a2] ? '/' : auth_path
    session[:a2] = nil
  end

  def index
    session[:a2] = authenticate? ? nil : 1
  end

  def logoff
    session[:uid] = nil
    redirect_to auth_path
  end

  def unlink
    current_user.oauths.where(id: params[:id]).destroy_all
    redirect_to auth_path
  end
end
