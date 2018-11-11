
module Api
    module V1  
        class ConfirmationController < ApiController
            before_action :require_login

            # GET /availabilitys
            def index
                if params[:live]
                    base = 'https://api.holidayextras.co.uk/v1/'
                    key = ENV["HX_KEY"]
                    abtanumber = ENV["HX_ABTNUMBER"]
                    password = ENV["HX_PASSWORD"]
                    initials = ENV["HX_INITIALS"]
                    token = ENV["HX_TOKEN"]
                    booking_ref = params[:reference]

                    url = "#{base}booking/#{booking_ref}/lite.js?ABTANumber=#{abtanumber}&Password=#{password}&Initials=#{initials}&token=#{token}&key=#{key}"
                    response = HTTParty.get(url)  
                    @confirmation = response.body
                    
                    
                    render json: @confirmation
                else
                    base = 'https://api.holidayextras.co.uk/sandbox/v1/'
                    key = ENV["HX_KEY"]
                    abtanumber = ENV["HX_ABTNUMBER"]
                    password = ENV["HX_PASSWORD"]
                    initials = ENV["HX_INITIALS"]
                    token = ENV["HX_TOKEN"]
                    booking_ref = params[:reference]

                    url = "#{base}booking/#{booking_ref}/lite.js?ABTANumber=#{abtanumber}&Password=#{password}&Initials=#{initials}&token=#{token}&key=#{key}"
                    response = HTTParty.get(url)  
                    @confirmation = response.body
                    
                    
                    render json: @confirmation
                end
                
            end
    
        
        end
    end
end
  