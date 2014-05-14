require 'spec_helper'

describe AdminController do
  before(:each) do
    controller.stub(:require_admin).and_return true
  end

  describe "index" do
    it "renders the view" do
      get :index
      expect(response).to render_template('admin')
    end

    it "gets all the admins" do
      users = Array.new(4) { User.create!(admin: false) }
      2.times { users << User.create!(admin: true) }

      get :index
      expect(assigns(:admins)).to eq(users[4..5])
    end
  end

  describe "revoke" do
    before(:each) do
      @user = User.create(admin: true)
    end
    it "returns to admin path" do
      get :revoke, id: @user.id
      assert_redirected_to '/admin'
    end

    it "removes the admin" do
      get :revoke, id: @user.id
      expect(User.find(@user.id).admin).to be_false
    end
  end

  describe "make" do
    before(:each) do
      @user = User.create(admin: false, email: 'useremail')
    end
    it "returns to admin path" do
      get :make, email: @user.email
      assert_redirected_to '/admin'
    end

    it "makes the user an admin" do
      get :make, email: @user.email
      expect(User.find(@user.id).admin).to be_true
    end
  end
end
