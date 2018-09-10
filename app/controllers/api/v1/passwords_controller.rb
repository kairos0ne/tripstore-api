module Api
    module V1  
        class PasswordsController < ApiController
            
            def forgot
                if params[:email].blank?
                  return render json: {error: 'Email not present'}, status: :unprocessable_entity
                end
            
                email = params[:email]
                user = User.find_by(email: email.downcase)
            
                if user.present? 
                  user.generate_password_token!
                  # SEND EMAIL HERE
                  # Deliver the signup email
                  NotificationsMailer.password_reset(user).deliver

                  render json: {status: 'ok'}, status: :ok
                else
                  render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
                end
            end
            
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