require 'rails_helper'

describe 'navigate' do
  let(:user) { FactoryGirl.create(:user)}

  let(:post) do
    Post.create(date: Date.today, rationale: "Rationale", user_id: user.id, overtime_request: 3.5)
  end
    
  before do 
    login_as(user, :scope => :user)
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

    it "has a scope so that only the post creator can see his own post" do
      other_user = User.create(first_name: 'Non', last_name: 'Authorized', email: "nonauth@example.com", password: "asdfasdf", password_confirmation: "asdfasdf", phone: "5402828076")
      post_from_other_user = Post.create(date: Date.today, rationale: "This post shouldn't be seen", user_id: other_user.id, overtime_request: 3.5)

      visit posts_path

      expect(page).to_not have_content(/This post shouldn't be seen/)
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
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Something Rational"
      fill_in 'post[overtime_request]', with: 4.5

      expect{ click_on "Save"}.to change(Post, :count).by(1)
    end

    it 'will have a user associated with post' do
      fill_in 'Date', with: Date.today
      fill_in 'Rationale', with: "Some new rationale"
      fill_in 'overtime_request', with: 4.5

      click_on "Save"
      expect(User.last.posts.last.rationale).to eq("Some new rationale")
    end

  end

  describe 'edit' do

    it "can be edited" do
      visit edit_post_path(post)

      fill_in 'post_date', with: Date.today
      fill_in 'post_rationale', with: "Edited Rationale"

      click_on 'Save'

      expect(page).to have_content("Edited Rationale")
    end

    it "can not be edited by non authorized user" do 
      logout(:user)
      non_authorized_user = FactoryGirl.create(:non_authorized_user)
      login_as(non_authorized_user, :scope => :user)

      visit edit_post_path(post)

      expect(current_path).to eq(root_path)
    end
  end

  describe "new" do
    it "has a link from homepage for new post" do 
      visit root_path

      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end

  describe "delete" do
    it "the post can be deleted" do
      logout(:user)

      user_for_delete = FactoryGirl.create(:user)
      login_as(user_for_delete, :scope => :user)

      post_to_delete = Post.create(date: Date.today, rationale: "Rationale", user_id: user_for_delete.id, overtime_request: 3.5)

      visit posts_path

      click_link("delete_post_#{post_to_delete.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end
end