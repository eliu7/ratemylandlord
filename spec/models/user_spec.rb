require 'spec_helper'

describe User do
  context "ratings" do
    before(:each) do
      @user = User.create!
      @ratings = Array.new(3) { Rating.create!(:user_id => @user.id) }
      @ratings << Rating.create!(:user_id => @user.id+1)
    end
    it "can get its ratings" do
      expect(@user.ratings).to eq(@ratings[0..-2])
    end
  end

  context "authorization" do
    before(:each) do
      @auth = double('authorization')
      @auth.stub(:slice).and_return({:id => nil})
      @auth.stub(:provider).and_return nil
      @auth.stub(:uid).and_return nil
      @auth.stub_chain(:info, :name).and_return nil
      @auth.stub_chain(:credentials, :token).and_return nil
      @auth.stub_chain(:credentials, :expires_at).and_return 0
    end

    it "returns the user for a valid email" do
      @auth.stub_chain(:info, :email).and_return("email@binghamton.edu")
      expect(User.from_omniauth(@auth)).to be
    end

    it "returns the nil for a invalid email" do
      @auth.stub_chain(:info, :email).and_return("email@gmail.edu")
      expect(User.from_omniauth(@auth)).to be_nil
    end
  end
end
