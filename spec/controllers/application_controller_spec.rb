require 'spec_helper'

describe ApplicationController do
  describe "current user" do
    it "gets the user correctly" do
      user = User.create!
      session[:user_id] = user.id
      expect(controller.current_user).to eq(user)
    end
    it "returns nil for no user" do
      session[:user_id] = nil
      expect(controller.current_user).to be_nil
    end
  end

  describe "admin" do
    it "returns true for admin" do
      user = User.create!(admin: true)
      controller.stub(:current_user) { user }
      expect(controller.admin?).to be_true
    end
    it "returns false for non-admin" do
      user = User.create!(admin: false)
      controller.stub(:current_user) { user }
      expect(controller.admin?).to be_false
    end
    it "returns false for no user" do
      controller.stub(:current_user) { nil }
      expect(controller.admin?).to be_false
    end
  end

  describe "require admin" do
    it "returns false for no admin" do
      controller.stub(:admin?) { false }
      controller.stub(:redirect_to)
      expect(controller.require_admin).to be_false
    end
    it "returns true for admin" do
      controller.stub(:admin?) { true }
      expect(controller.require_admin).to be_true
    end
  end
  describe "require sign in" do
    it "returns false for not signed in" do
      controller.stub(:current_user) { nil }
      controller.stub(:redirect_to)
      expect(controller.require_sign_in).to be_false
    end
    it "returns true for admin" do
      user = User.create!
      controller.stub(:current_user) { user }
      expect(controller.require_sign_in).to be_true
    end
  end
end
