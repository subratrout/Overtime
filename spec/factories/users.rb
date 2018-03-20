FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end
  
  factory :user do
    first_name 'Subrat'
    last_name 'Rout'
    email {generate :email}
    password "password"
    password_confirmation "password"
    phone "5402828244"
  end

  factory :admin_user, class: "AdminUser" do
    first_name 'Admin'
    last_name 'User'
    email {generate :email}
    password "asdfasdf"
    password_confirmation "asdfasdf"
    phone "2354455345"
  end

  factory :non_authorized_user, class: "User" do
    first_name 'Non'
    last_name 'Authorized'
    email { generate :email }
    password "asdfasdf"
    password_confirmation "asdfasdf"
    phone "4432223453"
  end
end