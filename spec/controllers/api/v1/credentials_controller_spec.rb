# spec/controllers/api/v1/admin_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::CredentialsController do

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
      expect(json_response.keys).to match_array("credentials")
    end
  end

  # Test that the user is returned on the show method 
  describe "GET #show" do

    before do
        user = FactoryBot.create(:admin, token_created_at: Time.zone.now.to_datetime)
        credential = FactoryBot.create :credential
        request.headers["Authorization"] = "Token " + user.token 
        get :show, params: { id: credential.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON body response contains expected credential attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array("credential")
    end

  end
  # Create a user in the db 
  describe "Credential #create" do

    it 'creates a new Credential' do
      expect { 
        credential = FactoryBot.create(:credential)
        credential.save 
      }.to change(Credential, :count).by(1)
    end

  end
  # Delete a user 
  describe "Credential #destroy" do

    it 'Deletes a Credential' do
      credential = FactoryBot.create(:credential)
      credential.save
      expect { credential.destroy }.to change(Credential, :count).by(-1)
    end

  end
end