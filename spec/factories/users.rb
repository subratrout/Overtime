FactoryGirl.define do
  factory :user do
    first_name 'Subrat'
    last_name 'Rout'
    email "test2@test.com"
    password "password"
    password_confirmation "password"
  end

  factory :admin_user, class: "AdminUser" do
    first_name 'Admin'
    last_name 'User'
    email "admin@user.com"
    password "asdfasdf"
    password_confirmation "asdfasdf"
  end
end