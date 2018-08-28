# spec/controllers/api/v1/trips_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::TripsController do

    before(:each) do
        user = FactoryBot.create :user
        trip = FactoryBot.create(:trip, user_id: user.id)
        request.headers["Authorization"] = "Token " + user.token  
    end

  # Test if all users are returned on the index method 
  describe "GET #index" do

    before do
        user = FactoryBot.create(:user, token_created_at: Time.zone.now.to_datetime)
        request.headers["Authorization"] = "Token " + user.token 
        get :index, params: { user_id: user.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected trips attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("trips")
    end

  end
  
  # Test that the user is returned on the show method 
  describe "GET #show" do

    before do
        user = FactoryBot.create(:user, token_created_at: Time.zone.now.to_datetime)
        trip = FactoryBot.create(:trip, user_id: user.id)
        request.headers["Authorization"] = "Token " + user.token 
        get :show, params: { user_id: user.id, id: trip.id  }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected trips attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("trip")
    end

  end
end