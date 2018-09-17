module Api
  module V1   
   class CredentialsController < ApiController
      before_action :require_login
      before_action :set_credential, only: [:show, :update, :destroy]

      swagger_controller :credentials, "Credentials Management"

      swagger_api :index do
        summary "Fetches all the credentials (admin only)"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :query, :name, :string, :required, "Optional Name Filter"
        response :ok
        response :unauthorized
        response :forbidden, "User does not have permissions"
      end    

      # GET /credentials
      def index
          if current_user.admin == true 
            if params[:name]
              @credentials = Credential.where(name: params[:name]).take
              render json: @credentials
            else
              @credentials = Credential.all 
              render json: @credentials
            end
          else
            render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
          end 
      end

      swagger_api :show do
        summary "Fetches a single Credential item"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :path, :id, :integer, :required, "Credential Id"
        response :ok, "Success", :Credential
        response :unauthorized
        response :unprocessable_entity
        response :forbidden
        response :not_found
      end

      # GET /credentials/1
      def show
        if current_user.admin == true
          render json: @credential
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end 
      end

      swagger_api :create do
        summary "Creates a new Credential"
        param :form, "credential[name]", :string, :required, "Name"
        param :form, "credential[password]", :string, :required, "Password"
        param :form, "credential[key]", :string, :required, "Key"
        param :form, "credential[initails]", :string, :required, "Initials"
        param :form, "credential[account_number]", :string, :required, "Account Number"
        response :created
        response :unauthorized
        response :unprocessable_entity
      end

      # POST /credentials
      def create
        if current_user.admin == true
          @credential = Credential.new(credential_params)

          if @credential.save
            render json: @credential, status: :created
          else
            render json: @credential.errors, status: :unprocessable_entity
          end
        else 
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end

      swagger_api :update do
        summary "Updates a Credential"
        param :path, :id, :integer, :required, "Credential Id"
        param :form, "credential[name]", :string, :required, "Name"
        param :form, "credential[password]", :string, :required, "Password"
        param :form, "credential[key]", :string, :required, "Key"
        param :form, "credential[initails]", :string, :required, "Initials"
        param :form, "credential[account_number]", :string, :required, "Account Number"
        response :created
        response :unauthorized
        response :unprocessable_entity
      end

      # PATCH/PUT /credentials/1
      def update
        if current_user.admin == true
          if @credential.update(credential_params)
            render json: @credential
          else
            render json: @credential.errors, status: :unprocessable_entity
          end
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end

      swagger_api :destroy do
        summary "Deletes an existing Credential item"
        param :header, :Authorization, :string, :required, "To authorize the requests."
        param :path, :id, :integer, :optional, "Credential Id"
        response :ok
        response :unauthorized
        response :forbidden
        response :not_found
      end

      # DELETE /credentials/1
      def destroy
        if current_user.admin == true
          @credential.destroy
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_credential
          @credential = Credential.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def credential_params
          params.require(:credential).permit(:password, :key, :account_number, :initials, :name)
        end
    end
  end
end
