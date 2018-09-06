module Api
  module V1
    class SessionsController < ApiController
      before_action :require_login, only: [:destroy]

      swagger_controller :sessions, "Session Management"

      swagger_api :create do
        summary "Logs a user in"
        param :form, :email, :string, :required, "User Email"
        param :form, :password, :string, :required, "User Password"
        response :ok
      end

      def create
        if user = User.valid_login?(params[:email], params[:password])
          user.allow_token_to_be_used_only_once
          send_auth_token_for_valid_login_of(user)
        else
          render_unauthorized("Error with your login or password")
        end
      end


      swagger_api :destroy do
        summary "Logs a user out"
        param :header, :Authoraization, :string, :required, "To authorize the requests."
        response :ok
        response :unauthorized
      end


      def destroy
        current_user.token_created_at = nil
        current_user.save
        head :ok
      end

      private

      def send_auth_token_for_valid_login_of(user)
        render json: { user: user }, :except=>  [:password_digest, :token_created_at]
      end
    end
  end 
end