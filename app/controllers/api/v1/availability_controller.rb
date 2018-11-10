
module Api
    module V1  
        class AvailabilityController < ApiController
            # before_action :require_login

            # GET /availabilitys
            def index
                if params[:live]
                    base = 'https://api.holidayextras.co.uk/v1/'
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
                else
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
                end
                
            end
    
        
        end
    end
end
  