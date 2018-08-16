module Api
  module V1

    class TripsController < ApiController
    before_action :require_login
    before_action :set_trip, only: [:show, :update, :destroy]

    # GET /trips
    def index
      user = User.find(params[:user_id])
      
      @trips = user.trip.all

      render json: @trips, pagination: "{total: }"
    end

    # GET /trips/1
    def show
      authorize! :read, @trip
      render json: @trip
    end

    # POST /trips
    def create
      @trip = Trip.new(trip_params)

      if @trip.save
        authorize! :create, @trip
        render json: @trip, status: :created
      else
        render json: @trip.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @trip.update(trip_params)
        authorize! :update, @trip
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
