require 'rails_helper'

RSpec.describe Trip, type: :model do
  it "is valid with valid attributes" do 
    user = FactoryBot.create(:user)
    trip = FactoryBot.create(:trip, user_id: user.id)
    expect(trip).to be_valid
  end
  it "is not valid without a start date" do
    user = FactoryBot.create(:user)
    trip = FactoryBot.create(:trip, user_id: user.id)
    trip.start_date = nil 
    expect(trip).to_not be_valid
  end
  it "is not valid without a end date" do
    user = FactoryBot.create(:user)
    trip = FactoryBot.create(:trip, user_id: user.id)
    trip.end_date = nil 
    expect(trip).to_not be_valid
  end
end
