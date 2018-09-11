module Api
    module V1  
        class PasswordsController < ApiController
          swagger_controller :passwords, "Password Management"
          # Forgoten password route  

          swagger_api :forgot do
            summary "Posts a email to the forgot password route"
            param :form, "email", :string, :required, "Email address"
            response :ok, "Success", :User
            response :unprocessable_entity
            response :not_found
          end
          

          def forgot
              if params[:email].blank?
                return render json: {error: 'Email not present'}, status: :unprocessable_entity
              end
          
              email = params[:email]
              user = User.find_by(email: email.downcase)
          
              if user.present? 
                user.generate_password_token!
                NotificationsMailer.password_reset(user).deliver
                render json: {status: 'ok'}, status: :ok
              else
                render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
              end
          end
          
          swagger_api :reset do
            summary "Posts a token and password to the reset route"
            param :query, :token, :string, :required, "Reset token"
            param :form, :password, :string, :required, "New Password"
            response :ok, "Success", :User
            response :unprocessable_entity
            response :not_found
          end


          # Reset password route 
          def reset
              token = params[:token].to_s
              if params[:token].blank?
                return render json: {error: 'Token not present'}
              end
          
              user = User.find_by(reset_password_token: token)
          
              if user.present? && user.password_token_valid?
                if user.reset_password!(params[:password])
                  render json: {status: 'ok'}, status: :ok
                else
                  render json: {error: user.errors.full_messages}, status: :unprocessable_entity
                end
              else
                render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
              end
          end

            # def update
            #     if !params[:password].present?
            #       render json: {error: 'Password not present'}, status: :unprocessable_entity
            #       return
            #     end
              
            #     if current_user.reset_password(params[:password])
            #       render json: {status: 'ok'}, status: :ok
            #     else
            #       render json: {errors: current_user.errors.full_messages}, status: :unprocessable_entity
            #     end
            # end
        end
    end
end