class ShippingAddress < ApplicationRecord
  belongs_to :order

  validates :postal_code, presence: true, 
                          format: { with: /\A\d{3}-\d{4}\z/, message: "は正しい形式で入力してください" }
  validates :address, presence: true
  validates :name, presence: true
  validates :phone_number, presence: true
end
