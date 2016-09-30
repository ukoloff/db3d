Rails.application.routes.draw do
  get '/', to: redirect('/tools')
  resources :tools
end
