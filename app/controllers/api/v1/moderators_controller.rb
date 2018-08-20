module Api
    module V1
      
      class ModeratorsController < ApiController
        
        before_action :require_login, only: [:create]
    
        
          def create
            @user = User.new(user_params)
            authorize! :create, @user
            if @user.save
              
              render json: @user, :except=>  [:password_digest, :token_created_at]
            else
              render json: @user.errors, status: :unprocessable_entity
            end
          end
  
          
          private
          
          # Use callbacks to share common setup or constraints between actions.
          def set_user
            @user = User.find(params[:id])
          end
  
          def user_params
            params.require(:user).permit(:name, :email, :admin, :member, :password, :password_confirmation)
          end
      end
    end
  end