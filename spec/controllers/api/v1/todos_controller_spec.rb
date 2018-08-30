require 'rails_helper'

RSpec.describe Api::V1::TodosController do

    before(:each) do
        user = FactoryBot.create :user
        trip = FactoryBot.create(:trip, user_id: user.id)
        todo = FactoryBot.create(:todo, trip_id: trip.id)
        request.headers["Authorization"] = "Token " + user.token  
    end

  # Test if all users are returned on the index method 
  describe "GET #index" do

    before do
        user = FactoryBot.create(:user, token_created_at: Time.zone.now.to_datetime)
        trip = FactoryBot.create(:trip, user_id: user.id)
        todo = FactoryBot.create(:todo, trip_id: trip.id)
        request.headers["Authorization"] = "Token " + user.token 
        get :index, params: { user_id: user.id, trip_id: trip.id, id: todo.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected trips attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("todos")
    end

  end

  # Test that the trip is returned on the show method 
  describe "GET #show" do

    before do
        user = FactoryBot.create(:user, token_created_at: Time.zone.now.to_datetime)
        trip = FactoryBot.create(:trip, user_id: user.id)
        todo = FactoryBot.create(:todo, trip_id: trip.id)
        request.headers["Authorization"] = "Token " + user.token 
        get :show, params: { user_id: user.id, trip_id: trip.id, id: todo.id  }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected trips attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("todo")
    end

  end

  # Create a Trip in the db 
  describe "Trip #create" do

    it 'creates a new Todo' do
      expect {
        user = FactoryBot.create(:user)
        trip = FactoryBot.create(:trip, user_id: user.id)
        todo = FactoryBot.create(:todo, trip_id: trip.id)
        todo.save
      }.to change(Todo, :count).by(1)
    end

  end
  # Delete a Trip 
  describe "Trip #destroy" do

    it 'Deletes a Trip' do
      user = FactoryBot.create(:user)
      trip = FactoryBot.create(:trip, user_id: user.id)
      todo = FactoryBot.create(:todo, trip_id: trip.id)
      expect { todo.destroy }.to change(Todo, :count).by(-1)
    end

  end

end