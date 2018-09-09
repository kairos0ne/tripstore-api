# spec/controllers/api/v1/admin_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::UsersController do

  before(:each) do
      user = create(:admin, token_created_at: Time.zone.now.to_datetime)
      user.save
      request.headers["Authorization"] = "Token " + user.token
  end  
  
  # Test that admin user has access to the users list endpoint 
  describe "GET #index" do
    before do
      get :index
    end
    it "returns http 200" do
        expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected user attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("users")
    end
  end

  # Test that the user is returned on the show method 
  describe "GET #show" do

    before do
        user = FactoryBot.create(:admin, token_created_at: Time.zone.now.to_datetime)
        request.headers["Authorization"] = "Token " + user.token 
        get :show, params: { id: user.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected user attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("user")
    end

  end
  # Create a user in the db 
  describe "User #create" do

    it 'creates a new User' do
      expect { 
        user = FactoryBot.create(:user)
        user.save 
      }.to change(User, :count).by(1)
    end

  end
  # Delete a user 
  describe "User #destroy" do

    it 'Deletes a user' do
      user = FactoryBot.create(:user)
      user.save
      expect { user.destroy }.to change(User, :count).by(-1)
    end

  end
end