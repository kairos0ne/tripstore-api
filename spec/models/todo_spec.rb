require 'rails_helper'

RSpec.describe Todo, type: :model do
  it "is valid with valid attributes" do 
    user = FactoryBot.create(:user)
    trip = FactoryBot.create(:trip, user_id: user.id)
    todo = FactoryBot.create(:todo, trip_id: trip.id)
    expect(todo).to be_valid
  end
  
  it "is not valid without a title" do 
    user = FactoryBot.create(:user)
    trip = FactoryBot.create(:trip, user_id: user.id)
    todo = FactoryBot.create(:todo, trip_id: trip.id)
    todo.title = nil 
    expect(todo).to_not be_valid
  end

  it "is not valid without a description" do 
    user = FactoryBot.create(:user)
    trip = FactoryBot.create(:trip, user_id: user.id)
    todo = FactoryBot.create(:todo, trip_id: trip.id)
    todo.description = nil 
    expect(todo).to_not be_valid
  end
end
