module Api
  module V1
    class ApiController < ActionController::Base
      include Rails::Pagination

      def require_login
        authenticate_token || render_unauthorized("Access denied")
      end
    
      def current_user
        @current_user ||= authenticate_token
      end
      
      rescue_from "AccessGranted::AccessDenied" do |exception|
        render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json
      end

      protected
    
      def render_unauthorized(message)
        errors = { errors: [ { detail: message } ] }
        render json: errors, status: :unauthorized
      end
    
      private
    
      def authenticate_token
        authenticate_with_http_token do |token, options|
          # Compare the tokens in a time-constant manner, to mitigate timing attacks.
          if user = User.with_unexpired_token(token, 2.days.ago)
      
            ActiveSupport::SecurityUtils.secure_compare(
                            ::Digest::SHA256.hexdigest(token),
                            ::Digest::SHA256.hexdigest(user.token))
            user
          end
        end
      end
    end
  end
end
