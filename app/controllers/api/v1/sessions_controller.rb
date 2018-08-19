module Api
  module V1
    class SessionsController < ApiController
      before_action :require_login, only: [:destroy]

      def create
        if user = User.valid_login?(params[:email], params[:password])
          user.allow_token_to_be_used_only_once
          send_auth_token_for_valid_login_of(user)
        else
          render_unauthorized("Error with your login or password")
        end
      end

      def destroy
        current_user.token_created_at = nil
        current_user.save
        head :ok
      end

      private

      def send_auth_token_for_valid_login_of(user)
        render json: { user: user }, :except=>  [:password_digest, :token_created_at, :admin, :member]
      end
    end
  end 
end