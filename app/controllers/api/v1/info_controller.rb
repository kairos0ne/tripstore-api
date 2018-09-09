
module Api
    module V1  
      class InfoController < ApiController
        before_action :require_login
        before_action :set_todo, only: [:show, :update, :destroy]

        swagger_controller :places, "Places Management"

        swagger_api :index do
          summary "Fetches info about the destination"
          notes "This lists all info about a destination"
          param :header, :Authorization, :string, :required, "To authorize the requests."
          param :path, :user_id, :integer, :required, "User Id"
          param :path, :trip_id, :integer, :required, "Trip Id"
          param :path, :destination_id, :integer, :required, "Destination Id"
          response :ok
          response :unauthorized
          response :forbidden, "User does not have permissions"
        end
  

        def index 
          if current_user.admin == true
            @client = GooglePlaces::Client.new(ENV["GOOGLE_API_KEY"])
            destination = Destination.find(params[:destination_id])
            @place = @client.spots_by_query(destination.title, detail: true)
            render json: @place, :root => 'place' 
          elsif current_user.id == user.id 
            @client = GooglePlaces::Client.new(ENV["GOOGLE_API_KEY"])
            destination = Destination.find(params[:destination_id])
            @place = @client.spots_by_query(destination.title, detail: true)
            render json: @place, :root => 'place' 
          else 
            render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
          end
        end
  
        private

      end
    end
  end
  