require 'spec_helper'

describe SessionsController do
  describe "create" do
    before(:each) do
      @redirect = '/admin'
      User.stub(:from_omniauth) { nil }
      session.stub(:delete) { @redirect }
    end

    it "returns to path in session" do
      get :create
      assert_redirected_to @redirect
    end

    it "sets the current user" do
      user = User.create!
      User.stub(:from_omniauth) { user }
      get :create
      expect(session[:user_id]).to eq(user.id)
    end
    it "has an error for an invalid user" do
      get :create
      expect(flash[:loginerror]).to be
    end
  end

  describe "destroy" do
    it "removes the current user" do
      get :destroy
      expect(session[:user_id]).to be_nil
    end
  end

  describe "signin" do
    it "redirects correctly" do
      get :signin
      assert_redirected_to '/auth/google_oauth2'
    end
  end
end
