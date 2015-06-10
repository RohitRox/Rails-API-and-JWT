FactoryGirl.define do
  factory :post do
    title FFaker::Lorem.sentence
    content FFaker::Lorem.paragraph
  end
end
