# spec/controllers/api/v1/places_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::PlacesController do

  # Test if all places are returned on the index method 
  describe "GET #index" do

    before do
        user = FactoryBot.create(:admin, token_created_at: Time.zone.now.to_datetime)
        trip = FactoryBot.create(:trip, user_id: user.id)
        destination = FactoryBot.create(:destination, trip_id: trip.id)
        request.headers["Authorization"] = "Token " + user.token 
        get :index, params: { user_id: user.id, trip_id: trip.id, destination_id: destination.id, lat: -33.8670522, lng: 151.1957362}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected places attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("places")
    end

  end

end