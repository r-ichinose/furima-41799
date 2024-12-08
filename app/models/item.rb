class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day

  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true,numericality: { only_integer: true,greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, presence: true, numericality: { only_integer: true, other_than: 1,  message: 'must be greater than 1'}
end
