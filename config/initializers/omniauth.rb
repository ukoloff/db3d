Rails.application.config.middleware.use OmniAuth::Builder do
  YAML.load_file(Rails.root + 'config/omniauth.yml').each do |k, v|
    provider k, *ENV["OA_#{k}"].split(':'), v
  end
end
