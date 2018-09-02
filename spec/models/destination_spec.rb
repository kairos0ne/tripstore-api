require 'rails_helper'

RSpec.describe Destination, type: :model do
  it "is valid with valid attributes" do 
    user = FactoryBot.create(:user)
    trip = FactoryBot.create(:trip, user_id: user.id)
    destination = FactoryBot.create(:destination, trip_id: trip.id)
    expect(destination).to be_valid
  end
  
  it "is not valid without a title" do 
    user = FactoryBot.create(:user)
    trip = FactoryBot.create(:trip, user_id: user.id)
    destination = FactoryBot.create(:destination, trip_id: trip.id)
    destination.title = nil 
    expect(destination).to_not be_valid
  end

end
