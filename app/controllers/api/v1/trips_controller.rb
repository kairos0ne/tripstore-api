module Api
  module V1

    class TripsController < ApiController
    before_action :require_login
    before_action :set_trip, only: [:show, :update, :destroy]

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

    # GET /trips/1
    def show
      authorize! :read, @trip
      render json: @trip
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

    # PATCH/PUT /trips/1
    def update
      authorize! :update, @trip
      if @trip.update(trip_params)
        render json: @trip
      else
        render json: @trip.errors, status: :unprocessable_entity
      end
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
        params.require(:trip).permit(:start_date, :end_date, :destination, :departure_airport_code, :arrival_airport_code, :departure_time, :arrival_time, :user_id)
      end
    end
  end
end
