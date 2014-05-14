require 'spec_helper'

describe Rating do
  before(:each) do
    @landlord = Landlord.create!
    @user = User.create!
    @rating = Rating.create!(user_id: @user.id, landlord_id: @landlord.id)
  end

  it "gets the landlord correctly" do
    expect(@rating.landlord).to eq(@landlord)
  end
  it "gets the user correctly" do
    expect(@rating.user).to eq(@user)
  end
end
