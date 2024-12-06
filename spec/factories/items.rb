require 'faker'

FactoryBot.define do
  factory :item do
    name             { Faker::Commerce.product_name }
    description      { Faker::Lorem.paragraph(sentence_count: 3) }
    price            { rand(300..9_999_999) }
    category_id      { rand(1..10) }
    condition_id     { rand(1..5) }
    shipping_fee_id  { rand(1..3) }
    prefecture_id    { rand(1..47) }
    shipping_day_id  { rand(1..3) }
  end
end