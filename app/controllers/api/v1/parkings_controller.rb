module Api
  module V1
    class ParkingsController < ApiController
      

      before_action :require_login
      before_action :set_parking, only: [:show, :update, :destroy]

      swagger_controller :parkings, "Parking Management"
    
      swagger_api :index do
        summary "Fetches all parkings for a given user"
        notes "This lists all the parkings for a user"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :query, :page, :integer, :optional, "Page number"
        param :query, :per_page, :integer, :optional, "Per page option"
        param :path, :user_id, :integer, :required, "User Id"
        response :ok
        response :unauthorized
        response :forbidden, "User does not have permissions"
      end

      # GET /parkings
            # GET /bookings
      def index
        # get the user from params 
        user = User.find(params[:user_id])
        if current_user.admin == true      
          
          if params[:page] && params[:per_page]
            @parkings = user.parking.all
            paginate json: @parkings,  meta: {
              total: @parkings.count,
              per_page: params[:per_page].to_i, 
              page: params[:page].to_i,
              pages: (@parkings.count / params[:per_page].to_f).ceil
            }
          else
            @parkings = user.parking.all
            render json: @parkings
          end
        
        elsif current_user == user.id
          if params[:page] && params[:per_page]  
            parkings = user.parking.all
            paginate json: @parkings,  meta: {
              total: @parkings.count,
              per_page: params[:per_page].to_i, 
              page: params[:page].to_i,
              pages: (@parkings.count / params[:per_page].to_f).ceil
            }
          else
            @parkings = user.parking.all
            render json: @parkings
          end
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end

      swagger_api :all_parkings do
        summary "Fetches all parkings for a given user. Only admins have access to this endpoint"
        notes "This lists all the parkings for a user"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :query, :page, :integer, :optional, "Page number"
        param :query, :per_page, :integer, :optional, "Per page option"
        param :path, :user_id, :integer, :required, "User Id"
        response :ok
        response :unauthorized
        response :forbidden, "User does not have permissions"
      end
      

       # GET /bookings
       def all_parkings
        if current_user.admin == true      
          if params[:page] && params[:per_page]  
            @parkings = Parking.all
            paginate json: @parkings,  meta: {
              total: @parkings.count,
              per_page: params[:per_page].to_i, 
              page: params[:page].to_i,
              pages: (@parkings.count / params[:per_page].to_f).ceil
            }
          else
            @parkings = Parking.all
            render json: @parkings
          end
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end

      swagger_api :show do
        summary "Fetches a single parking by ID"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :path, :id, :integer, :optional, "Parking Id"
        response :ok, "Success", :Booking
        response :unauthorized
        response :forbidden, "User does not have permissions"
        response :not_found
      end

      # GET /parkings/1
      def show
        # get the user from params 
        user = User.find(params[:user_id])
        if current_user.admin == true
          render json: @parking
        elsif current_user == user.id 
          render json: @parking
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end 


      swagger_api :create do
        summary "Creates a booking for a user"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :form, "parking[ABTANumber]", :string, :optional, "ABTNumber"
        param :form, "parking[ArrivalDate]", :date, :optional, "Arrival Date"
        param :form, "parking[ArrivalTime]", :time, :optional, "Arrival Time"
        param :form, "parking[DepartDate]", :date, :optional,  "Departure Date"
        param :form, "parking[DepartTime]", :time, :optional,  "Departure Time"
        param :form, "parking[NumberOfPax]", :integer, :optional, "Number of Pax"
        param :form, "parking[Title]", :string, :optional, "Title"
        param :form, "parking[Initial]", :string, :optional, "Initial"
        param :form, "parking[Surname]", :string, :optional, "Surname"
        param :form, "parking[Email]", :string, :optional,  "Email"
        param :form, "parking[Waiver]", :string, :optional,  "Customer Waiver"
        param :form, "parking[Remarks]", :string, :optional, "Remarks"
        response :ok
        response :unauthorized
        response :unprocessable_entity
        response :forbidden
      end


      # POST /parkings
      def create
        # get the user from params 
        user = User.find(params[:user_id])
        @parking = Parking.new(parking_params)
        @parking.user_id = user.id
        authorize! :create, @parking

        if @parking.save
          render json: @parking, status: :created
        else
          render json: @parking.errors, status: :unprocessable_entity
        end
      end

      swagger_api :update do
        summary "Updates a booking for a user"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :path, :id, :integer, :required, "Parking Id"
        param :form, "parking[ABTANumber]", :string, :optional, "ABTNumber"
        param :form, "parking[ArrivalDate]", :date, :optional, "Arrival Date"
        param :form, "parking[ArrivalTime]", :time, :optional, "Arrival Time"
        param :form, "parking[DepartDate]", :date, :optional,  "Departure Date"
        param :form, "parking[DepartTime]", :time, :optional,  "Departure Time"
        param :form, "parking[NumberOfPax]", :integer, :optional, "Number of Pax"
        param :form, "parking[Title]", :string, :optional, "Title"
        param :form, "parking[Initial]", :string, :optional, "Initial"
        param :form, "parking[Surname]", :string, :optional, "Surname"
        param :form, "parking[Email]", :string, :optional,  "Email"
        param :form, "parking[Waiver]", :string, :optional,  "Customer Waiver"
        param :form, "parking[Remarks]", :string, :optional, "Remarks"
        response :ok
        response :unauthorized
        response :unprocessable_entity
        response :forbidden
      end

      # PATCH/PUT /parkings/1
      def update
        authorize! :update, @parking
        if @parking.update(parking_params)
          render json: @parking
        else
          render json: @parking.errors, status: :unprocessable_entity
        end
      end

      swagger_api :destroy do
        summary "Deletes an existing Parking item"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :path, :id, :integer, :required, "Parking Id"
        response :ok
        response :unauthorized
        response :not_found
        response :forbidden
      end

      # DELETE /parkings/1
      def destroy
        authorize! :destroy, @parking
        @parking.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_parking
          @parking = Parking.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def parking_params
          params.require(:parking).permit(:ArrivalDate, :ArrivalTime, :DepartDate, :DepartTime, :NumberOfPax, :Title, :Initial, :Surname, :Email, :Waiver, :Remarks, :ABTANumber, :success, :active, :user_id)
        end

    end
  end
end
