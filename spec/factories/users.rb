FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password "password"
    password_confirmation "password"
  end

end
