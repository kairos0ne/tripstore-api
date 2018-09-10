require 'rails_helper'

RSpec.describe Parking, type: :model do
  it "is valid with valid attributes" do 
    user = FactoryBot.create(:user)
    parking = FactoryBot.create(:parking, user_id: user.id)
    expect(parking).to be_valid
  end
  it "is not valid without a ArrivalDate" do
    user = FactoryBot.create(:user)
    parking = FactoryBot.create(:parking, user_id: user.id)
    parking.ArrivalDate = nil 
    expect(parking).to_not be_valid
  end
  it "is not valid without a ArrivalTime" do
    user = FactoryBot.create(:user)
    parking = FactoryBot.create(:parking, user_id: user.id)
    parking.ArrivalTime = nil 
    expect(parking).to_not be_valid
  end
  it "is not valid without a DepartDate" do
    user = FactoryBot.create(:user)
    parking = FactoryBot.create(:parking, user_id: user.id)
    parking.DepartDate = nil 
    expect(parking).to_not be_valid
  end
  it "is not valid without a DepartTime" do
    user = FactoryBot.create(:user)
    parking = FactoryBot.create(:parking, user_id: user.id)
    parking.DepartTime = nil 
    expect(parking).to_not be_valid
  end
  it "is not valid without a ABTANumber" do
    user = FactoryBot.create(:user)
    parking = FactoryBot.create(:parking, user_id: user.id)
    parking.ABTANumber = nil 
    expect(parking).to_not be_valid
  end
  it "is not valid without a Email" do
    user = FactoryBot.create(:user)
    parking = FactoryBot.create(:parking, user_id: user.id)
    parking.Email = nil 
    expect(parking).to_not be_valid
  end

end
