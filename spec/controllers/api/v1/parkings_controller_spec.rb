# spec/controllers/api/v1/parkings_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::ParkingsController do

    before(:each) do
        user = FactoryBot.create :admin
        parking = FactoryBot.create(:parking, user_id: user.id)
        request.headers["Authorization"] = "Token " + user.token  
    end

  # Test is all parkings are returned 
  describe "GET #index" do

    before do
        user = FactoryBot.create(:admin, token_created_at: Time.zone.now.to_datetime)
        request.headers["Authorization"] = "Token " + user.token 
        get :index, params: { user_id: user.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected parkings attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("parkings")
    end

  end

  # Test that the parking is returned on the show method 
  describe "GET #show" do

    before do
        user = FactoryBot.create(:admin, token_created_at: Time.zone.now.to_datetime)
        parking = FactoryBot.create(:parking, user_id: user.id)
        request.headers["Authorization"] = "Token " + user.token 
        get :show, params: { user_id: user.id, id: parking.id  }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected bookings attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("parking")
    end

  end

  # Create a Parking in the db 
  describe "Parking #create" do

    it 'creates a new Parking' do
      expect {
        user = FactoryBot.create(:user)
        parking = FactoryBot.create(:parking, user_id: user.id)
        parking.save
      }.to change(Parking, :count).by(1)
    end

  end
  # Delete a Parking 
  describe "Parking #destroy" do

    it 'Deletes a Parking' do
      user = FactoryBot.create(:user)
      parking = FactoryBot.create(:parking, user_id: user.id)
      expect { parking.destroy }.to change(Parking, :count).by(-1)
    end

  end

end