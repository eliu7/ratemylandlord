require 'spec_helper'

describe LandlordsController do
  context "color test" do
    it { controller.get_color(1).should == 'redback' }
    it { controller.get_color(2).should == 'redyellowback' }
    it { controller.get_color(3).should == 'yellowback' }
    it { controller.get_color(4).should == 'greenyellowback' }
    it { controller.get_color(5).should == 'greenback' }
  end

  describe "index" do
    it "gets all landlords for no search" do
      Landlord.should_receive(:all)
      get :index
    end
    it "searches if specified" do
      Landlord.should_receive(:search).with("something")
      get :index, search: "something"
    end
  end

  describe "show" do
    before(:each) do
      @landlord = Landlord.create!
    end

    it "shows the page" do
      get :show, id: @landlord.id
      expect(response).to render_template('show')
    end
  end

  describe "destroy" do
    before(:each) do
      @landlord = Landlord.create!
    end

    it "destroys the landlord" do
      get :destroy, id: @landlord.id
      expect(Landlord.where(id: @landlord.id)).to be_empty
    end
  end
end
