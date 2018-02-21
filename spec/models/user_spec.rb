require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(first_name: "Subrat", last_name: "Rout", email: "test2@testmail.com", password: "password", password_confirmation: "password")
  end
  describe "Create an User" do
   
    it "can be created" do
      expect(@user).to be_valid
    end

    it "cannot be created without the first_name and last_name" do
      @user.first_name = nil
      @user.last_name = nil

      expect(@user).to_not be_valid
    end
  end

  describe "custom name methods" do
    it 'has a full name method that combines first and last name' do
      expect(@user.full_name).to eq("ROUT, SUBRAT")
    end
  end
end
