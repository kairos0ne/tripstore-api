class HomeController < ActionController::Base
    def index 
        render template: "home/index"
    end 
end