class Item < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true,numericality: { only_integer: true,greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
