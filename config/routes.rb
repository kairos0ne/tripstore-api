Rails.application.routes.draw do
  get "/" => "home#index"
  namespace :api do 
    namespace :v1 do 
      resources :users do 
        resources :trips
      end
      scope do
        post   "/login"   => "sessions#create"
        delete "/logout"  => "sessions#destroy"
      end
    end
  end
end