
module Api
    module V1  
      class MuseumsController < ApiController
        before_action :require_login
        before_action :set_todo, only: [:show, :update, :destroy]

        swagger_controller :museums, "Museums Management"

        swagger_api :index do
          summary "Fetches all Museums for a given Destination. Uses Google Places Api"
          notes "This lists all the museums that are nearby the destination"
          param :header, :Authorization, :string, :required, "To authorize the requests."
          param :path, :user_id, :integer, :required, "User Id"
          param :path, :trip_id, :integer, :required, "Trip Id"
          param :path, :destination_id, :integer, :required, "Destination Id"
          response :ok
          response :unauthorized
          response :forbidden, "User does not have permissions"
        end
  
  
        # GET /todos
        def index
          # Get all the google results for a trip destination.
          user = User.find(params[:user_id])
          if current_user.admin == true
            @client = GooglePlaces::Client.new(ENV["GOOGLE_API_KEY"])
            destination = Destination.find(params[:destination_id])
            @places = @client.spots_by_query('Nearby ' + destination.title, :types => ['museum'], multipage: true)
            render json: @places, :root => 'museums'
          elsif current_user.id == user.id 
            @client = GooglePlaces::Client.new(ENV["GOOGLE_API_KEY"])
            destination = Destination.find(params[:destination_id])
            @places = @client.spots_by_query('Nearby ' + destination.title, :types => ['museum'], multipage: true)
            render json: @places, :root => 'museums'
          else
            render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
          end
        end
  
        private

      end
    end
  end
  