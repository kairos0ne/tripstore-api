# spec/controllers/api/v1/admin_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::UsersController do

  before(:each) do
      user = FactoryBot.create(:user, token_created_at: Time.zone.now.to_datetime)
      user.save
      request.headers["Authorization"] = "Token " + user.token
  end  
  
  # Test that member user has no access to the users list endpoint 
  describe "GET #index" do
    before do
      get :index
    end
    it "returns http 200" do
        expect(response).to have_http_status(:forbidden)
    end
    it "JSON body response contains expected user attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("error")
    end
  end

  # Test that a user can see their own data 
  describe "GET #show" do

    before do
        user = FactoryBot.create(:user, token_created_at: Time.zone.now.to_datetime)
        request.headers["Authorization"] = "Token " + user.token 
        get :show, params: { id: user.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected error" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("user")
    end

  end
  # Test that a user can not see other users
  describe "GET #show" do

    before do
        user = FactoryBot.create(:user, token_created_at: Time.zone.now.to_datetime)
        member = FactoryBot.create(:user, token_created_at: Time.zone.now.to_datetime)
        request.headers["Authorization"] = "Token " + member.token 
        get :show, params: { id: user.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:forbidden)
    end

    it "JSON body response contains error" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("error")
    end

  end

  # Delete a user 
  describe "User #destroy" do

    it 'Gives an error for delete when its not users own data' do
      user = FactoryBot.create(:user)
      user.save
      expect { user.destroy }.to change(User, :count).by(-1)
    end

  end

end