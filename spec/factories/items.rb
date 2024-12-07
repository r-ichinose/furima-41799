FactoryBot.define do
  factory :item do
    name             { Faker::Commerce.product_name }
    description      { Faker::Lorem.paragraph(sentence_count: 3) }
    price            { rand(300..9_999_999) }
    category_id      { rand(2..10) }
    condition_id     { rand(2..6) }
    shipping_fee_id  { rand(2..3) }
    prefecture_id    { rand(2..47) }
    shipping_day_id  { rand(2..4) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end