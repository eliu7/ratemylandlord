require 'spec_helper'

describe RatingsController do
  describe "new" do
    it "renders the view" do
      controller.stub(:require_sign_in) { true }
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "create" do
    before(:each) do
      @info = double('info')
      @info.stub(:[]) { '0' }
      @info = { comment: 'comment' }
      Rating.categories.each { |cat| @info[cat] = '0' }
      user = User.create!
      controller.stub(:current_user) { user }
      @landlord = Landlord.create
    end

    it "goes to the landlord path" do
      post :create, id: @landlord.id, rating: @info
      assert_redirected_to landlord_path(@landlord.id)
    end

    it "creates a new landlord if not specified" do
      name = 'name'
      post :create, rating: @info, landlord: { name: name }
      expect(Landlord.find_by_name(name)).to be
    end
  end

  describe "destroy" do
    before(:each) do
      @landlord = Landlord.create!
      @rating = Rating.create!(landlord_id: @landlord.id)
    end

    it "goes back to the landlord path" do
      get :destroy, id: @rating.id
      assert_redirected_to landlord_path(page: 1, id: @landlord.id)
    end

    it "deletes the rating" do
      get :destroy, id: @rating.id
      expect(Rating.where(id: @rating.id)).to be_empty
    end
  end
end
