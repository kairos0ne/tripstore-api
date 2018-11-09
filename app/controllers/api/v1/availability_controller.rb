
module Api
    module V1  
        class AvailabilityController < ApiController
            # before_action :require_login
            
            swagger_controller :availability, "Availability Management"
    
            swagger_api :index do
                summary "Fetches all available hotels for a given user"
                notes "Gets all hotels for a given location"
                param :path, :location_code, :string, :required, "Location Code"
                param :path, :arrival_date, :date, :required, "Arrival Date"
                param :path, :nights, :integer, :required, "Nights"
                param :path, :room_type, :string, :required, "Room Type Code"
                param :path, :language_code, :string, :required, "Language Code"
                param :path, :type, :string, :required, "Type should be hotel"
                response :ok
            end

            # GET /availabilitys
            def index
                base = 'https://api.holidayextras.co.uk/sandbox/v1/'
                location = params[:location_code]
                key = ENV["HX_KEY"]
                abtanumber = ENV["HX_ABTNUMBER"]
                password = ENV["HX_PASSWORD"]
                initials = ENV["HX_INITIALS"]
                token = ENV["HX_TOKEN"]
                arrival_date = params[:arrival_date]
                nights = params[:nights]
                roomtype = params[:room_type]
                lang = params[:language_code] 
                type = params[:type]

                url = "#{base}#{type}/#{location}/lite.js?ABTANumber=#{abtanumber}&Password=#{password}&Initials=#{initials}&token=#{token}&key=#{key}&ArrivalDate=#{arrival_date}&Nights=#{nights}&RoomType=#{roomtype}&lang=#{lang}"
                response = HTTParty.get(url)  
                @hotels = response.body
                
                
                render json: @hotels
                # render :json @hotels
            end
    
        
        end
    end
end
  