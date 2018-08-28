require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do 
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end
  it "is not valid without a email" do
    user = FactoryBot.create(:user)
    user.email = nil 
    expect(user).to_not be_valid
  end
end
