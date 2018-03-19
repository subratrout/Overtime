require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Create a Post" do
    before do
      @post = FactoryGirl.create(:post)
    end
    
    it 'can be created' do 
      expect(@post).to be_valid
    end

    it 'cannot be created without a date, rationale and overtime_request' do
      @post.date = nil
      @post.rationale = nil
      @post.overtime_request = nil

      expect(@post).to_not be_valid
    end
  end
end
