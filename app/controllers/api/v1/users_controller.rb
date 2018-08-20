module Api
  module V1
    
    class UsersController < ApiController
      
      before_action :set_user, only: [:show, :update, :destroy]
      before_action :require_login, only: [:show, :index, :update, :create_admin, :destroy]
      
        def new
          @user = User.new
        end
        
        
        # GET /user/:id
        def show
          
          user = User.find(params[:id])
          if current_user.id == user.id
            render json: @user
          else 
            authorize! :read, @user

            render json: @user
          end
        end

        def index

          @user = current_user
          authorize! :read, @user

          @users = User.all

          if params[:page]

            paginate json: @users, meta: {
              total: @users.count,
              per_page: params[:per_page].to_i, 
              page: params[:page].to_i, 
              pages: (@users.count / params[:per_page].to_f).ceil
            }
          else
            render json: @users
          end

        end
      
        def create
          @user = User.new(user_params)
          if @user.save
            
            render json: @user, :except=>  [:password_digest, :token_created_at]
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /users/1
        def update
          authorize! :update, @user
          if @user.update(user_params)
            
            render json: @user, :except=>  [:password_digest, :token_created_at]
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end

        def newadmin
          @user = User.new(admin_params)
          if @user.save
            
            render json: @user, :except=>  [:password_digest, :token_created_at]
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end

        # DELETE /users/1
        def destroy
          authorize! :destroy, @user
          @user.destroy
        end
      
        private
        
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        end

        def user_params
          params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

        def admin_params
          params.require(:user).permit(:name, :email, :admin, :member, :password, :password_confirmation)
        end
    end
  end
end