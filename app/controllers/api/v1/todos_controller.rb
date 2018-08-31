
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
          # If the params contain 'page'
          if params[:page]
            # Paginate the results  
            paginate json: @todos, meta: {
              total: @todos.count,
              per_page: params[:per_page].to_i, 
              page: params[:page].to_i,
              pages: (@todos.count / params[:per_page].to_f).ceil
            }
          # Else render the full json   
          else
            render json: @todos
          end
        # Check that the current user matches the user from the URL 
        elsif current_user.id == user.id 
          # get the trip from params 
          trip = Trip.find(params[:trip_id])
          @todos = trip.todo.all
          if params[:page]
            # Paginate the results  
            paginate json: @todos, meta: {
              total: @todos.count,
              per_page: params[:per_page].to_i, 
              page: params[:page].to_i,
              pages: (@todos.count / params[:per_page].to_f).ceil
            }
          # Else render the full json   
          else
            render json: @todos
          end
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end

      # GET /todos/1
      def show
        user = User.find(params[:user_id])
        authorize! :read, @todo
        if current_user.admin == true
          render json: @todo
        elsif current_user.id == user.id  
          render json: @todo
        else
          render :json => {:error => "You don't have permissions to visit this endpoint"}.to_json, :status => :forbidden
        end
      end

      # POST /todos
      def create
        @todo = Todo.new(todo_params)
        @todo.trip_id = params[:trip_id]
        if @todo.save
          render json: @todo, status: :created
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
