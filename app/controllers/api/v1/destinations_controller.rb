module Api
  module V1
    class DestinationsController < ApiController
      before_action :set_destination, only: [:show, :update, :destroy]

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

      # GET /destinations/1
      def show
        render json: @destination
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

      # PATCH/PUT /destinations/1
      def update
        if @destination.update(destination_params)
          render json: @destination
        else
          render json: @destination.errors, status: :unprocessable_entity
        end
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