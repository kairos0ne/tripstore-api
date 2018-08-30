
module Api
  module V1  
    class TodosController < ApiController
      before_action :require_login
      before_action :set_todo, only: [:show, :update, :destroy]

      # GET /todos
      def index
        
        # get the user from params 
        user = User.find(params[:user_id])
        
        if current_user.admin == true
            # get the trip from params 
            trip = Trip.find(params[:trip_id])
            
            @todos = trip.todo.all

          render json: @todos
        elsif current_user.id == user.id
          # get the trip from params 
          trip = Trip.find(params[:trip_id])
          
          @todos = trip.todo.all
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end

      # GET /todos/1
      def show
        authorize! :read, @todo
        render json: @todo
      end

      # POST /todos
      def create
        @todo = Todo.new(todo_params)

        if @todo.save
          render json: @todo, status: :created, location: @todo
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /todos/1
      def update
        if @todo.update(todo_params)
          render json: @todo
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      # DELETE /todos/1
      def destroy
        @todo.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_todo
          @todo = Todo.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def todo_params
          params.require(:todo).permit(:title, :description, :trip_id)
        end
    end
  end
end
