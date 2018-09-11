module Api
  module V1

    class BookingsController < ApiController
      before_action :require_login
      before_action :set_booking, only: [:show, :update, :destroy]

      swagger_controller :bookings, "Booking Management"
    
      swagger_api :index do
        summary "Fetches all bookings for a given user"
        notes "This lists all the bookings for a user"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :query, :page, :integer, :optional, "Page number"
        param :query, :per_page, :integer, :optional, "Per page option"
        param :path, :user_id, :integer, :required, "User Id"
        response :ok
        response :unauthorized
        response :forbidden, "User does not have permissions"
      end

      # GET /bookings
      def index
        # get the user from params 
        user = User.find(params[:user_id])
        if current_user.admin == true      
          
          if params[:page] && params[:per_page]  
            @bookings = user.booking.all
            paginate json: @bookings,  meta: {
              total: @bookings.count,
              per_page: params[:per_page].to_i, 
              page: params[:page].to_i,
              pages: (@bookings.count / params[:per_page].to_f).ceil
            }
          else
            @bookings = user.booking.all
            render json: @bookings
          end
        
        elsif current_user == user.id
          if params[:page] && params[:per_page]  
            @bookings = user.booking.all
            paginate json: @bookings,  meta: {
              total: @bookings.count,
              per_page: params[:per_page].to_i, 
              page: params[:page].to_i,
              pages: (@bookings.count / params[:per_page].to_f).ceil
            }
          else
            @bookings = user.booking.all
            render json: @bookings
          end
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end

      swagger_api :all_bookings do
        summary "Fetches all bookings. Admin only"
        notes "This lists all the bookings"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :query, :page, :integer, :optional, "Page number"
        param :query, :per_page, :integer, :optional, "Per page option"
        param :path, :user_id, :integer, :required, "User Id"
        response :ok
        response :unauthorized
        response :forbidden, "User does not have permissions"
      end
      

      # GET /bookings
      def all_bookings
        # get the user from params 
        if current_user.admin == true      
          
          if params[:page] && params[:per_page]  
            @bookings = Booking.all
            paginate json: @bookings,  meta: {
              total: @bookings.count,
              per_page: params[:per_page].to_i, 
              page: params[:page].to_i,
              pages: (@bookings.count / params[:per_page].to_f).ceil
            }
          else
            @bookings = Booking.all
            render json: @bookings
          end
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end

      swagger_api :show do
        summary "Fetches a single booking by ID"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :path, :id, :integer, :optional, "Booking Id"
        response :ok, "Success", :Booking
        response :unauthorized
        response :forbidden, "User does not have permissions"
        response :not_found
      end

      # GET /bookings/1
      def show
        # get the user from params 
        user = User.find(params[:user_id])
        if current_user.admin == true
          render json: @booking
        elsif current_user == user.id 
          render json: @booking
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end 

      swagger_api :create do
        summary "Creates a booking for a user"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :form, "booking[ABTANumber]", :string, :required, "ABTNumber"
        param :form, "booking[token]", :string, :required, "token"
        param :form, "booking[ArrivalDate]", :date, :required, "Arrival Date"
        param :form, "booking[Nights]", :integer, :required, "Nights"
        param :form, "booking[RoomCode]", :string, :required,  "Room Code"
        param :form, "booking[Adults]", :integer, :required,  "Adults Staying"
        param :form, "booking[Children]", :integer, :required, "Children Staying"
        param :form, "booking[ParkingDays]", :integer, :required, "Parking Days"
        param :form, "booking[Title]", :string, :required, "Title"
        param :form, "booking[Initial]", :string, :required, "Initial"
        param :form, "booking[Surname]", :string, :required,  "Surname"
        param :form, "booking[Address]", :string, :required,  "Address"
        param :form, "booking[Town]", :string, :required, "Town"
        param :form, "booking[County]", :string, :required, "County"
        param :form, "booking[PostCode]", :string, :required, "Post Code"
        param :form, "booking[DayPhone]", :integer, :optional, "Day Phone"
        param :form, "booking[Email]", :string, :required, "Email Address"
        param :form, "booking[CustomerRef]", :string, :optional, "Customer Reference"
        param :form, "booking[Remarks]", :string, :optional, "Customer Remarks"
        param :form, "booking[Waiver]", :boolean, :optional, "Customer Waiver"
        param :form, "booking[DataProtection]", :string, :optional, "Data Protection"
        param :form, "booking[PriceCheckFlag]", :string, :required, "Price Checked Flagged"
        param :form, "booking[PriceCheckPrice]", :float, :required, "Price"
        param :form, "booking[System]", :string, :required, "System"
        param :form, "booking[lang]", :string, :required, "Language"
        param :form, "booking[SecondRoomType]", :string, :optional, "Second Room Type"
        param :form, "booking[SecondRoomCode]", :string, :optional, "Second Room Code"
        param :form, "booking[SecondRoomAdults]", :integer, :optional, "Second Room Adults Number"
        param :form, "booking[SecondRoomChildren]", :integer, :optional, "Second Room Children Number"
        param :form, "booking[success]", :boolean, :optional, "Success Status"
        param :form, "booking[active]", :boolean, :optional, "Active Status"
        response :ok
        response :unauthorized
        response :unprocessable_entity
        response :forbidden
      end

      # POST /bookings
      def create
        # get the user from params 
        user = User.find(params[:user_id])
        
        @booking = Booking.new(booking_params)
        authorize! :create, @booking
        @booking.user_id = user.id

        if @booking.save
          render json: @booking, status: :created
        else
          render json: @booking.errors, status: :unprocessable_entity
        end
      end

      swagger_api :update do
        summary "Updates a booking for a user"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :path, :id, :integer, :required, "Booking Id"
        param :form, "booking[ABTANumber]", :string, :required, "ABTNumber"
        param :form, "booking[token]", :string, :required, "token"
        param :form, "booking[ArrivalDate]", :date, :required, "Arrival Date"
        param :form, "booking[Nights]", :integer, :required, "Nights"
        param :form, "booking[RoomCode]", :string, :required,  "Room Code"
        param :form, "booking[Adults]", :integer, :required,  "Adults Staying"
        param :form, "booking[Children]", :integer, :required, "Children Staying"
        param :form, "booking[ParkingDays]", :integer, :required, "Parking Days"
        param :form, "booking[Title]", :string, :required, "Title"
        param :form, "booking[Initial]", :string, :required, "Initial"
        param :form, "booking[Surname]", :string, :required,  "Surname"
        param :form, "booking[Address]", :string, :required,  "Address"
        param :form, "booking[Town]", :string, :required, "Town"
        param :form, "booking[County]", :string, :required, "County"
        param :form, "booking[PostCode]", :string, :required, "Post Code"
        param :form, "booking[DayPhone]", :integer, :optional, "Day Phone"
        param :form, "booking[Email]", :string, :required, "Email Address"
        param :form, "booking[CustomerRef]", :string, :optional, "Customer Reference"
        param :form, "booking[Remarks]", :string, :optional, "Customer Remarks"
        param :form, "booking[Waiver]", :boolean, :optional, "Customer Waiver"
        param :form, "booking[DataProtection]", :string, :optional, "Data Protection"
        param :form, "booking[PriceCheckFlag]", :string, :required, "Price Checked Flagged"
        param :form, "booking[PriceCheckPrice]", :float, :required, "Price"
        param :form, "booking[System]", :string, :required, "System"
        param :form, "booking[lang]", :string, :required, "Language"
        param :form, "booking[SecondRoomType]", :string, :optional, "Second Room Type"
        param :form, "booking[SecondRoomCode]", :string, :optional, "Second Room Code"
        param :form, "booking[SecondRoomAdults]", :integer, :optional, "Second Room Adults Number"
        param :form, "booking[SecondRoomChildren]", :integer, :optional, "Second Room Children Number"
        param :form, "booking[success]", :boolean, :optional, "Success Status"
        param :form, "booking[active]", :boolean, :optional, "Active Status"
        response :ok
        response :unauthorized
        response :unprocessable_entity
        response :forbidden
      end


      # PATCH/PUT /bookings/1
      def update
        authorize! :update, @booking
        if @booking.update(booking_params)
          render json: @booking
        else
          render json: @booking.errors, status: :unprocessable_entity
        end
      end


      swagger_api :destroy do
        summary "Deletes an existing Booking item"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :path, :user_id, :integer, :required, "User Id"
        param :path, :id, :integer, :required, "Booking Id"
        response :ok
        response :unauthorized
        response :not_found
        response :forbidden
      end

      # DELETE /bookings/1
      def destroy
        authorize! :destroy, @booking
        @booking.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_booking
          @booking = Booking.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def booking_params
          params.require(:booking).permit(:ABTANumber, :token, :ArrivalDate, :Nights, :RoomCode, :Adults, :Children, :ParkingDays, :Title, :Initial, :Surname, :Address, :Town, :County, :PostCode, :DayPhone, :Email, :CustomerRef, :Remarks, :Waiver, :DataProtection, :PriceCheckFlag, :PriceCheckPrice, :System, :lang, :SecondRoomType, :SecondRoomCode, :SecondRoomAdults, :SecondRoomChildren, :success, :active, :user_id)
        end
    end
  end
end