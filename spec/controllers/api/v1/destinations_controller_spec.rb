# spec/controllers/api/v1/trips_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::DestinationsController do

    before(:each) do
        user = FactoryBot.create :user
        trip = FactoryBot.create(:trip, user_id: user.id)
        destination = FactoryBot.create(:destination, trip_id: trip.id)
        request.headers["Authorization"] = "Token " + user.token  
    end

  # Test if all users are returned on the index method 
  describe "GET #index" do

    before do
        user = FactoryBot.create(:user, token_created_at: Time.zone.now.to_datetime)
        trip = FactoryBot.create(:trip, user_id: user.id)
        destination = FactoryBot.create(:destination, trip_id: trip.id)
        request.headers["Authorization"] = "Token " + user.token 
        get :index, params: { user_id: user.id, trip_id: trip.id, destination_id: destination.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected destinations attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("destinations")
    end

  end

  # Test that the trip is returned on the show method 
  describe "GET #show" do

    before do
        user = FactoryBot.create(:user, token_created_at: Time.zone.now.to_datetime)
        trip = FactoryBot.create(:trip, user_id: user.id)
        destination = FactoryBot.create(:destination, trip_id: trip.id)
        request.headers["Authorization"] = "Token " + user.token 
        get :show, params: { user_id: user.id, trip_id: trip.id, id: destination.id  }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected destinations attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("destination")
    end

  end

  # Create a Trip in the db 
  describe "Trip #create" do

    it 'creates a new Destination' do
      expect {
        user = FactoryBot.create(:user)
        trip = FactoryBot.create(:trip, user_id: user.id)
        destination = FactoryBot.create(:destination, trip_id: trip.id)
        destination.save
      }.to change(Destination, :count).by(1)
    end

  end
  # Delete a Trip 
  describe "Destination #destroy" do

    it 'Deletes a Destination' do
      user = FactoryBot.create(:user)
      trip = FactoryBot.create(:trip, user_id: user.id)
      destination = FactoryBot.create(:destination, trip_id: trip.id)
      expect { destination.destroy }.to change(Destination, :count).by(-1)
    end

  end

end