Rails.application.routes.draw do
  get '/api/v1/docs', to: redirect('https://documenter.getpostman.com/view/8307881/UVC2J9Xr')

  post '/login', to: 'authentication#login'
  post '/logout', to: 'authentication#logout'

  namespace :api do
    resources :users, only: %i[create]
  end
end
