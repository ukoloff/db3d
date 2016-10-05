class AuthController < ActionController::Base
  def callback
    auth_hash = request.env['omniauth.auth']
    render plain: YAML.dump(auth_hash)
  end
end
