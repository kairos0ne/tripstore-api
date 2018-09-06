module Api
  module V1
    class DestinationsController < ApiController
      before_action :set_destination, only: [:show, :update, :destroy]

      swagger_controller :destinations, "Destination Management"

      swagger_api :index do
        summary "Fetches all the destinations for a given trip"
        notes "This lists all the destinations for a trip. Admins have access to all user data. Members have access to own data. eg http://localhost:3000/api/v1/users/1/trips/1/destinations"
        param :header, :Authoraization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :path, :trip_id, :integer, :required, "Trip Id"
        response :ok
        response :unauthorized
        response :forbidden, "User does not have permissions"
      end

      # GET /destinations
      def index
        user = User.find(params[:user_id])
        if current_user.admin == true
          trip = Trip.find(params[:trip_id])  
          @destinations = trip.destination.all
          render json: @destinations        
        elsif current_user.id == user.id
          trip = Trip.find(params[:trip_id])  
          @destinations = trip.destination.all
          render json: @destinations 
        else 
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end

      swagger_api :show do
        summary "Fetches a single destination"
        param :header, :Authoraization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :path, :trip_id, :integer, :required, "Trip Id"
        param :path, :id, :integer, :required, "Destination Id"
        response :ok
        response :unauthorized
        response :forbidden, "User does not have permissions"
      end

      # GET /destinations/1
      def show
        user = User.find(params[:user_id])
        if current_user.admin == true
          render json: @destination
        elsif current_user.id == user.id  
          render json: @destination
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end

      swagger_api :create do
        summary "Creates a new Destination"
        param :header, :Authoraization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :path, :trip_id, :integer, :required, "Trip Id"
        param :form, "destination[title]", :string, :required, "Todo Title"
        param :form, "destination[description]", :string, :optional, "Todo Description"
        response :ok
        response :unauthorized
        response :unprocessable_entity
        response :forbidden
      end

      # POST /destinations
      def create
        trip = Trip.find(params[:trip_id])
        @destination = Destination.new(destination_params)
        @destination.trip_id = trip.id

        if @destination.save
          render json: @destination, status: :created
        else
          render json: @destination.errors, status: :unprocessable_entity
        end
      end


      swagger_api :update do
        summary "Updates a Destination"
        param :header, :Authoraization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :path, :trip_id, :integer, :required, "Trip Id"
        param :form, "destination[title]", :string, :optional, "Todo Title"
        param :form, "destination[description]", :string, :optional, "Todo Description"
        response :ok
        response :unauthorized
        response :unprocessable_entity
        response :forbidden
      end


      # PATCH/PUT /destinations/1
      def update
        if @destination.update(destination_params)
          render json: @destination
        else
          render json: @destination.errors, status: :unprocessable_entity
        end
      end

      swagger_api :destroy do
        summary "Deletes an existing Destination item"
        param :header, :Authoraization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :path, :trip_id, :integer, :required, "Trip Id"
        param :path, :id, :integer, :require, "Destination Id"
        response :ok
        response :unauthorized
        response :not_found
        response :forbidden
      end

      # DELETE /destinations/1
      def destroy
        @destination.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_destination
          @destination = Destination.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def destination_params
          params.require(:destination).permit(:title, :description, :trip_id)
        end
    end
  end
end