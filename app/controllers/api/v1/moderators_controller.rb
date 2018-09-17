module Api
    module V1
      
      class ModeratorsController < ApiController
        
        before_action :require_login, only: [:create]
        
        swagger_controller :moderators, "Moderators Management"

        swagger_api :create do
          summary "Creates a Admin user"
          notes "Only admins have access to this endpoint"
          param :header, :Authorization, :string, :required, "To authorize the requests."
          param :form, "user[name]", :string, :optional, "User Name"
          param :form, "user[email]", :string, :required, "User Email"
          param :form, "user[password]", :string, :required, "User Password"
          param :form, "user[password_confirmation]", :string, :required, "Password Confirmation"
          param :form, "user[admin]", :boolean, :required, "Admin Role (default false)"
          param :form, "user[member]", :boolean, :required, "Member Role (default true)"
          response :ok
          response :unauthorized
          response :unprocessable_entity
          response :forbidden
        end
        
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