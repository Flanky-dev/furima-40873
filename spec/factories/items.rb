FactoryBot.define do
  factory :item do
    name              { 'MyString' }
    description       { 'MyText' }
    price             { 1000 }
    category_id       { 2 }
    status_id         { 2 }
    shipping_fee_id   { 2 }
    prefecture_id     { 2 }
    shipping_day_id   { 2 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
