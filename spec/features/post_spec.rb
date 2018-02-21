require 'rails_helper'

describe 'navigate' do
  before do 
    user = User.create(first_name: "First Name", last_name: "Last Name", email: "test@test.com", password:"asdfasdf", password_confirmation:"asdfasdf")
    login_as(user, :scope => :user)
  end
  describe 'index' do
    it 'can be reached successfully' do
      visit posts_path
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Post' do
      visit posts_path
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of Posts' do
      post1 = Post.create(date: Date.today, rationale: "Post1")
      post2 = Post.create(date: Date.today, rationale: "Post2")
      visit posts_path
      expect(page).to have_content(/Post1|Post2/)
    end
  end

  describe 'creation' do
    before do 
      user = User.create(first_name: "First Name", last_name: "Last Name", email: "test@test.com", password:"asdfasdf", password_confirmation:"asdfasdf")
      login_as(user, :scope => :user)
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
end