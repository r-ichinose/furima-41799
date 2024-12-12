class OrderForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building, :phone_number, :token

  validates :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :phone_number, :token, presence: { message: "can't be blank" }
  validates :prefecture_id, presence: { message: "can't be blank" }, numericality: { other_than: 0, message: "can't be blank" }
  validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid. Input only number" },
                            length: { in: 10..11, message: "is too short" }

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create(user_id: user_id, item_id: item_id)
      ShippingAddress.create(
        post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, order_id: order.id
      )
    end
    true
  rescue => e
    puts e.message
    puts e.backtrace
    false
  end
end