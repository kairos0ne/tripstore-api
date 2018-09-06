
module Api
    module V1  
      class PlacesController < ApiController
        before_action :require_login
        before_action :set_todo, only: [:show, :update, :destroy]

        swagger_controller :places, "Places Management"

        swagger_api :index do
          summary "Fetches all Places for a given Latitude and longitude. Uses Google Places Api"
          notes "This lists all the places that are nearby the destination"
          param :header, :Authorization, :string, :required, "To authorize the requests."
          param :path, :user_id, :integer, :required, "User Id"
          param :path, :trip_id, :integer, :required, "Trip Id"
          param :path, :destination_id, :integer, :required, "Destination Id"
          param :query, :lat, :integer, :required, "Latitude"
          param :query, :lon, :integer, :required, "Longitude"
          response :ok
          response :unauthorized
          response :forbidden, "User does not have permissions"
        end
  
        # GET /todos
        def index
          # Get all the google results for a given lat and lng.
          user = User.find(params[:user_id])
            if current_user.admin == true
                if params[:lat] && params[:lon]
                    @client = GooglePlaces::Client.new(ENV["GOOGLE_API_KEY"])
                    destination = Destination.find(params[:destination_id])
                    @places = @client.spots(params[:lat], params[:lon], :types => ['establishment'])
                    render json: @places, :root => 'places' 
                else 
                    render :json => {:error => "No longitude and latitude supplied"}.to_json, :status => :forbidden
                end
            elsif current_user.id == user.id 
                if params[:lat] && params[:lon]
                    @client = GooglePlaces::Client.new(ENV["GOOGLE_API_KEY"])
                    destination = Destination.find(params[:destination_id])
                    @places = @client.spots(params[:lat], params[:lon], :types => ['establishment'])
                    render json: @places, :root => 'places' 
                else 
                    render :json => {:error => "No longitude and latitude supplied"}.to_json, :status => :forbidden
                end
            else
                render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
            end
        end
  
        private

      end
    end
  end
  