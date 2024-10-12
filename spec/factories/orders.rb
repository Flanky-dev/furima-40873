FactoryBot.define do
  factory :order_shipping do
    postal_code    { '123-4567' }
    prefecture_id  { 2 } # assuming 1 is an invalid value like "--"
    city           { '横浜市緑区' }
    address { '青山1-1-1' }
    building       { '柳ビル103' } # Optional field
    phone_number   { '09012345678' }
    token          { 'tok_abcdefghijk00000000000000000' } # Mock token for card
  end
end
