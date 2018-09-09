<<<<<<< HEAD
# spec/controllers/api/v1/bookings_controller_spec.rb
=======
# spec/controllers/api/v1/booking_controller_spec.rb
>>>>>>> develop

require 'rails_helper'

RSpec.describe Api::V1::BookingsController do

    before(:each) do
        user = FactoryBot.create(:admin, token_created_at: Time.zone.now.to_datetime)
        booking = FactoryBot.create(:booking, user_id: user.id)
        request.headers["Authorization"] = "Token " + user.token  
    end

<<<<<<< HEAD
  # Test if all bookings are returned on the index method 
=======
  # Test is all bookings are returned 
>>>>>>> develop
  describe "GET #index" do

    before do
        user = FactoryBot.create(:admin, token_created_at: Time.zone.now.to_datetime)
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

<<<<<<< HEAD
  # Test that the booking is returned on the show method 
=======
  # Test that the booking is returned 
>>>>>>> develop
  describe "GET #show" do

    before do
        user = FactoryBot.create(:admin, token_created_at: Time.zone.now.to_datetime)
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

<<<<<<< HEAD
  # Create a Booking in the db 
=======
  # Create a booking in the DB
>>>>>>> develop
  describe "Booking #create" do

    it 'creates a new Booking' do
      expect {
        user = FactoryBot.create(:user)
        booking = FactoryBot.create(:booking, user_id: user.id)
        booking.save
      }.to change(Booking, :count).by(1)
    end

  end
<<<<<<< HEAD
  # Delete a Booking 
=======
  # Delete a Booking
>>>>>>> develop
  describe "Booking #destroy" do

    it 'Deletes a Booking' do
      user = FactoryBot.create(:user)
      booking = FactoryBot.create(:booking, user_id: user.id)
      expect { booking.destroy }.to change(Booking, :count).by(-1)
    end

  end

end