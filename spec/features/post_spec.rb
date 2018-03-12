require 'rails_helper'

describe 'navigate' do
  before do 
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
  end
  describe 'index' do
    
    before do
      visit posts_path
    end

    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Post' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of Posts' do
      post1 = FactoryGirl.build_stubbed(:post)
      post2 = FactoryGirl.build_stubbed(:second_post)
      visit posts_path
      expect(page).to have_content(/Rationale|content/)
    end
  end

  describe 'creation' do
    before do 
      visit new_post_path
    end
    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'Date', with: Date.today
      fill_in 'Rationale', with: "Something Rational"

      click_on "Save"
      expect(page).to have_content("Something Rational")
    end

    it 'will have a user associated with post' do
      fill_in 'Date', with: Date.today
      fill_in 'Rationale', with: "Some new rationale"

      click_on "Save"
      expect(User.last.posts.last.rationale).to eq("Some new rationale")
    end

  end

  describe 'edit' do
    before do
      @post = FactoryGirl.create(:post)
    end

    it "can be reached by clicking edit on the index page" do
      visit posts_path
      
      click_link( "edit_#{@post.id}")
      expect(page.status_code).to eq(200)
    end

    it "can be edited" do
      visit edit_post_path(@post)

      fill_in 'post_date', with: Date.today
      fill_in 'post_rationale', with: "Edited Rationale"

      click_on 'Save'

      expect(page).to have_content("Edited Rationale")


    end
  end
end