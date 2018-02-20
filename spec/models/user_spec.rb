require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Create an User" do
    before do
      @user = User.create(first_name: "subrat", last_name: "Rout", email: "test2@testmail.com", password: "password", password_confirmation: "password")
    end
    
    it "can be created" do
      expect(@user).to be_valid
    end

    it "cannot be created without the first_name and last_name" do
      @user.first_name = nil
      @user.last_name = nil

      expect(@user).to_not be_valid
    end
  end
end
