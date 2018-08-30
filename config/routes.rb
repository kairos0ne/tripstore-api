Rails.application.routes.draw do
  
  get "/" => "home#index"
  namespace :api do 
    namespace :v1 do 
      resources :users do 
        resources :trips do 
          resources :todos
        end
      end
      
      scope do
        post "/moderator" => "moderators#create"
        post   "/login"   => "sessions#create"
        delete "/logout"  => "sessions#destroy"
      end
    end
  end
end