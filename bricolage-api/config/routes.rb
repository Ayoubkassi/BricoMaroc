require 'sidekiq/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  mount Sidekiq::Web => '/sidekiq'

  get "up" => "rails/health#show", as: :rails_health_check

  # route for auth

  namespace :api do 
    namespace :v1 do
      post "/signup" , to: "users#signup"
      post "/login", to: "users#login"
    end 
  end 

  # config/routes.rb
  namespace :api do
    namespace :v1 do
      resources :profiles do
        collection do
          get 'search'
        end
      end
    end
  end


end
