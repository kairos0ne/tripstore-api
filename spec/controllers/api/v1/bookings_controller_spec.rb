# spec/controllers/api/v1/trips_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::BookingsController do

    before(:each) do
        user = FactoryBot.create (:user, admin: true)
        booking = FactoryBot.create(:booking, user_id: user.id)
        request.headers["Authorization"] = "Token " + user.token  
    end

  # Test if all users are returned on the index method 
  describe "GET #index" do

    before do
        user = FactoryBot.create(:user, admin: true, token_created_at: Time.zone.now.to_datetime)
        request.headers["Authorization"] = "Token " + user.token 
        get :index, params: { user_id: user.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected bookings attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("bookings")
    end

  end

  # Test that the trip is returned on the show method 
  describe "GET #show" do

    before do
        user = FactoryBot.create(:user, token_created_at: Time.zone.now.to_datetime)
        booking = FactoryBot.create(:booking, user_id: user.id)
        request.headers["Authorization"] = "Token " + user.token 
        get :show, params: { user_id: user.id, id: booking.id  }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected bookings attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("booking")
    end

  end

  # Create a Trip in the db 
  describe "Booking #create" do

    it 'creates a new Booking' do
      expect {
        user = FactoryBot.create(:user)
        booking = FactoryBot.create(:booking, user_id: user.id)
        booking.save
      }.to change(Booking, :count).by(1)
    end

  end
  # Delete a Trip 
  describe "Booking #destroy" do

    it 'Deletes a Booking' do
      user = FactoryBot.create(:user)
      booking = FactoryBot.create(:booking, user_id: user.id)
      expect { booking.destroy }.to change(Booking, :count).by(-1)
    end

  end

end