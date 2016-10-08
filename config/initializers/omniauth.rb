Rails.application.config.middleware.use OmniAuth::Builder do
  ini = YAML.load_file Rails.root + 'config/omniauth.yml'
  ENV.each do |k, v|
    next unless z = /^OA_(\w+)$/.match(k)
    provider z[1], *v.split(':'), ini[z[1]] || {}
  end
end
