Rails.application.routes.draw do
  
  get "/" => "home#index"
  get '/api' => redirect('/dist/index.html?url=/api-docs.json')
  namespace :api do 
    namespace :v1 do 
      resources :credentials
      get "/all_bookings" => "bookings#all_bookings"
      get "/all_parkings" => "parkings#all_parkings"
      resources :users do 
        resources :bookings
        resources :parkings
        resources :trips do
          resources :destinations do 
            resources :museums, only: [:index]
            resources :bars, only: [:index]
            resources :restaurants, only: [:index]
            resources :parks, only: [:index]
            resources :clubs, only: [:index]
            resources :places, only: [:index]
            resources :info, only: [:index]
          end 
          resources :todos
        end
      end
      
      scope do
        post "/moderator" => "moderators#create"
        post   "/login"   => "sessions#create"
        delete "/logout"  => "sessions#destroy"
        post '/forgot', to: 'passwords#forgot'
        post '/reset', to: 'passwords#reset'
        # put '/update', to: 'passwords#update'
      end
    end
  end
end