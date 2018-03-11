FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end
  
  factory :user do
    first_name 'Subrat'
    last_name 'Rout'
    email "test@test.com"
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