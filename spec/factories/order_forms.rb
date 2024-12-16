FactoryBot.define do
  factory :order_form do
    post_code     { '123-4567' }
    prefecture_id { 1 }
    city          { 'Tokyo' }
    address       { 'Shibuya 1-1-1' }
    building      { 'LA Building' }
    phone_number  { '09012345678' }
    token         { 'tok_abcdefghijk00000000000000000' }
    association :user
    association :item
  end
end