
module Api
    module V1  
      class BarsController < ApiController
        before_action :require_login
        before_action :set_todo, only: [:show, :update, :destroy]
  
        # GET /todos
        def index
          # Get all the google results for a trip destination.
          user = User.find(params[:user_id])
          if current_user.admin == true
            @client = GooglePlaces::Client.new(ENV["GOOGLE_API_KEY"])
            destination = Destination.find(params[:destination_id])
            @places = @client.spots_by_query('Nearby ' + destination.title, :types => ['bar'], multipage: true)
            render json: @places, :root => 'bars'  
          elsif current_user.id == user.id 
            @client = GooglePlaces::Client.new(ENV["GOOGLE_API_KEY"])
            destination = Destination.find(params[:destination_id])
            @places = @client.spots_by_query('Nearby ' + destination.title, :types => ['bar'], multipage: true)
            render json: @places, :root => 'bars'
          else
            render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
          end
        end
  
        private

      end
    end
  end
  