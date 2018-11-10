
module Api
    module V1  
        class PaymentController < ApiController
            before_action :require_login

            # GET /availabilitys
            def create
                if params[:live]
                    # Base URL for requests 
                    base = 'https://api.holidayextras.co.uk/v1/'
                    # Params for building the URL 
                    key = ENV["HX_KEY"]
                    abtanumber = ENV["HX_ABTNUMBER"]
                    password = ENV["HX_PASSWORD"]
                    initials = ENV["HX_INITIALS"]
                    token = ENV["HX_TOKEN"]
                    location = params[:location_code]
                    arrival_date = params[:arrival_date]
                    nights = params[:nights]
                    roomcode = params[:room_code]
                    lang = params[:language_code] 
                    type = params[:type]
                    adults = params[:adults]
                    children = params[:children]
                    parking_days = params[:parking_days]
                    title = params[:title]
                    initial = params[:initial]
                    surname = params[:surname]
                    address = params[:address]
                    town = params[:town]
                    county = params[:county]
                    post_code = params[:post_code]
                    dayphone = params[:dayphone]
                    email = params[:email]
                    customer_ref = params[:customer_ref]
                    remarks = params[:remarks]
                    waiver = params[:waiver]
                    data_protection = params[:data_protection]
                    check_price_flag = params[:check_price_flag]
                    price = params[:price_check_price]
                    platform = params[:system]

                    url = "#{base}#{type}/#{location}/lite.js?ABTANumber=#{abtanumber}&Password=#{password}&Initials=#{initials}&token=#{token}&key=#{key}&ArrivalDate=#{arrival_date}&Nights=#{nights}&RoomCode=#{roomcode}&lang=#{lang}&Adults=#{adults}&Children=#{children}&ParkingDays=#{parking_days}&Title=#{title}&Initial=#{initial}&Surname=#{surname}&Address=#{address}&Town=#{town}&County=#{county}&PostCode=#{post_code}&DayPhone=#{dayphone}&Email=#{email}&CustomerRef=#{customer_ref}&Remarks=#{remarks}&Waiver=#{waiver}&DataProtection=#{data_protection}&PriceCheckFlag=#{check_price_flag}&PriceCheckPrice=#{price}&System=#{platform}"
                    response = HTTParty.post(url)  
                    @booking = response.body
                    
                    render json: @booking
                
                else
                    # Base URL for requests 
                    base = 'https://api.holidayextras.co.uk/sandbox/v1/'
                    # Params for building the URL 
                    key = ENV["HX_KEY"]
                    abtanumber = ENV["HX_ABTNUMBER"]
                    password = ENV["HX_PASSWORD"]
                    initials = ENV["HX_INITIALS"]
                    token = ENV["HX_TOKEN"]
                    location = params[:location_code]
                    arrival_date = params[:arrival_date]
                    nights = params[:nights]
                    roomcode = params[:room_code]
                    lang = params[:language_code] 
                    type = params[:type]
                    adults = params[:adults]
                    children = params[:children]
                    parking_days = params[:parking_days]
                    title = params[:title]
                    initial = params[:initial]
                    surname = params[:surname]
                    address = params[:address]
                    town = params[:town]
                    county = params[:county]
                    post_code = params[:post_code]
                    dayphone = params[:dayphone]
                    email = params[:email]
                    customer_ref = params[:customer_ref]
                    remarks = params[:remarks]
                    waiver = params[:waiver]
                    data_protection = params[:data_protection]
                    check_price_flag = params[:check_price_flag]
                    price = params[:price_check_price]
                    platform = params[:system]
    
                    url = "#{base}#{type}/#{location}/lite.js?ABTANumber=#{abtanumber}&Password=#{password}&Initials=#{initials}&token=#{token}&key=#{key}&ArrivalDate=#{arrival_date}&Nights=#{nights}&RoomCode=#{roomcode}&lang=#{lang}&Adults=#{adults}&Children=#{children}&ParkingDays=#{parking_days}&Title=#{title}&Initial=#{initial}&Surname=#{surname}&Address=#{address}&Town=#{town}&County=#{county}&PostCode=#{post_code}&DayPhone=#{dayphone}&Email=#{email}&CustomerRef=#{customer_ref}&Remarks=#{remarks}&Waiver=#{waiver}&DataProtection=#{data_protection}&PriceCheckFlag=#{check_price_flag}&PriceCheckPrice=#{price}&System=#{platform}"
                    response = HTTParty.post(url)  
                    @booking = response.body
                    
                    render json: @booking
                end
            end
        end
    end
end
  