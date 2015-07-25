FactoryGirl.define do
  factory :profile do
    first_name "Firstname"
    last_name "Lastname"
    gender "Male"
    avatar_url "http://lorempixel.com/output/animals-q-c-120-120-8.jpg"
    bio "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua."
    location "Woodside, NY"
  end
end
