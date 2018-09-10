require 'rails_helper'

RSpec.describe Booking, type: :model do
  it "is valid with valid attributes" do 
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    expect(booking).to be_valid
  end
  it "is not valid without a ABTANumber" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.ArrivalDate = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a token" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.token = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a ArrivalDate" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.ArrivalDate = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a Nights" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.Nights = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a RoomCode" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.RoomCode = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a Adults" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.Adults = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a Children" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.Children = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a ParkingDays" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.ParkingDays = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a Title" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.Title = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a Initial" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.Initial = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a Surname" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.Surname = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a Address" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.Address = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a Town" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.Town = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a County" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.County = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a PostCode" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.PostCode = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a Email" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.Email = nil 
    expect(booking).to_not be_valid
  end
#   TODO - include waiver in validations 
#   it "is not valid without a Waiver" do
#     user = FactoryBot.create(:user)
#     booking = FactoryBot.create(:booking, user_id: user.id)
#     booking.Waiver = nil 
#     expect(booking).to_not be_valid
#   end
  it "is not valid without a PriceCheckFlag" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.PriceCheckFlag = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a PriceCheckPrice" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.PriceCheckPrice = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a System" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.System = nil 
    expect(booking).to_not be_valid
  end
  it "is not valid without a lang" do
    user = FactoryBot.create(:user)
    booking = FactoryBot.create(:booking, user_id: user.id)
    booking.lang = nil 
    expect(booking).to_not be_valid
  end


  
end
