class AuthController < ApplicationController
  def callback
    auth_hash = request.env['omniauth.auth']
    flash[:yml] = YAML.dump auth_hash.as_json
    redirect_to auth_path
  end

  def index
  end
end
