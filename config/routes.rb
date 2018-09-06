Rails.application.routes.draw do
  
  
  get "/" => "home#index"
  get '/api' => redirect('/dist/index.html?url=/api-docs.json')
  namespace :api do 
    namespace :v1 do 
      resources :users do 
        resources :trips do
          resources :destinations do 
            resources :museums, only: [:index]
            resources :bars, only: [:index]
            resources :restaurants, only: [:index]
            resources :parks, only: [:index]
            resources :clubs, only: [:index]
          end 
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