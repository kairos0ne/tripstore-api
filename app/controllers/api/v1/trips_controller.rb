module Api
  module V1

    class TripsController < ApiController
    before_action :require_login
    before_action :set_trip, only: [:show, :update, :destroy]

    swagger_controller :trips, "Trip Management"
    
    swagger_api :index do
      summary "Fetches all the trips for a given user"
      notes "This lists all the trips for user. Admins have access to all user data. Members have access to own data. eg http://localhost:3000/api/v1/users/1/trips?page=1&per_page=10"
      param :header, :Authoraization, :string, :required, "To authorize the requests."
      param :query, :page, :integer, :optional, "Page number"
      param :query, :per_page, :integer, :optional, "Per page option"
      param :path, :user_id, :integer, :required, "User Id"
      response :ok
      response :unauthorized
      response :unprocessable_entity
      response :forbidden, "User does not have permissions"
    end

    # GET /trips
    def index 
      # get the user from params 
      user = User.find(params[:user_id])
      # check if the current user is an admin 
      if current_user.admin == true
        @trips = user.trip.all
        # Check if the the params contains pagination 
        if params[:page]
          
          paginate json: @trips, meta: {
            total: @trips.count,
            per_page: params[:per_page].to_i, 
            page: params[:page].to_i,
            pages: (@trips.count / params[:per_page].to_f).ceil
          }

        else 
          # Render json response for all trips  
          render json: @trips
        end
       # Check is the user is current user if not render unathorised 
      elsif current_user.id == user.id
        @trips = user.trip.all
        if params[:page]
          paginate json: @trips, meta: {
            total: @trips.count,
            per_page: params[:per_page].to_i, 
            page: params[:page].to_i,
            pages: (@trips.count / params[:per_page].to_f).ceil
          }
        else
          render json: @trips
        end
      else 
        render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
      end
    end

    swagger_api :show do
      summary "Fetches a single trip by ID"
      param :header, :Authoraization, :string, :required, "To authorize the requests."
      param :path, :user_id, :integer, :optional, "User Id"
      param :path, :id, :integer, :optional, "Trip Id"
      response :ok, "Success", :Trip
      response :unauthorized
      response :unprocessable_entity
      response :not_found
    end

    # GET /trips/1
    def show
      authorize! :read, @trip
      render json: @trip
    end

    swagger_api :create do
      summary "Creates a new Trip"
      param :header, :Authoraization, :string, :required, "To authorize the requests."
      param :path, :user_id, :integer, :required, "User Id"
      param :form, "trip[start_date]", :timestamp, :required, "Start Date"
      param :form, "trip[end_date]", :timestamp, :required, "End Date"
      param :form, "trip[departure_airport_code]", :string, "Depature Airport Code"
      param :form, "trip[arrival_airport_code]", :string, "Arrival Airport Code"
      param :form, "trip[departure_time]", :string, "Departure Time"
      param :form, "trip[arrival_time]", :string, "Arrival Time"
      response :ok
      response :unauthorized
      response :forbidden
      response :unprocessable_entity
    end

    # POST /trips
    def create
      @trip = Trip.new(trip_params)
      @trip.user_id = params[:user_id]
        authorize! :create, @trip
      if @trip.save
        render json: @trip, status: :created
      else
        render json: @trip.errors, status: :unprocessable_entity
      end
    end


    swagger_api :update do
      summary "Updates a Trip by ID"
      param :header, :Authoraization, :string, :required, "To authorize the requests."
      param :path, :user_id, :integer, :required, "User Id"
      param :path, :id, :integer, :required, "Trip Id"
      param :form, "trip[start_date]", :timestamp, :required, "Start Date"
      param :form, "trip[end_date]", :timestamp, :required, "End Date"
      param :form, "trip[departure_airport_code]", :string, :optional, "Depature Airport Code"
      param :form, "trip[arrival_airport_code]", :string, :optional, "Arrival Airport Code"
      param :form, "trip[departure_time]", :string, :optional,  "Departure Time"
      param :form, "trip[arrival_time]", :string, :optional,  "Arrival Time"
      response :ok
      response :unauthorized
      response :unprocessable_entity
      response :forbidden
    end

    # PATCH/PUT /trips/1
    def update
      authorize! :update, @trip
      if @trip.update(trip_params)
        render json: @trip
      else
        render json: @trip.errors, status: :unprocessable_entity
      end
    end

    swagger_api :destroy do
      summary "Deletes an existing Trip item"
      param :header, :Authoraization, :string, :required, "To authorize the requests."
      param :path, :user_id, :integer, :required, "User Id"
      param :path, :id, :integer, :required, "Trip Id"
      response :ok
      response :unauthorized
      response :not_found
      response :forbidden
    end

    # DELETE /trips/1
    def destroy
      authorize! :destroy, @trip
      @trip.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_trip
        @trip = Trip.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def trip_params
        params.require(:trip).permit(:start_date, :end_date, :departure_airport_code, :arrival_airport_code, :departure_time, :arrival_time, :user_id)
      end
    end
  end
end
