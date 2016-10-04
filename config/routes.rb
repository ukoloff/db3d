Rails.application.routes.draw do
  get '/', to: redirect('/tools')
  resources :tools
  get '/auth/:provider/callback', to: 'auth#callback'
end
