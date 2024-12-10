class Order
  include ActiveModel::Model

  belongs_to :user
  belongs_to :item
  has_one :shipping_address

  attr_accessor :user_id, :item_id, :shipping_address, :postal_code, :city, :address, :phone_number, :token

  validates :user_id, :item_id, :shipping_address, :postal_code, :city, :address, :phone_number, :token, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ } # 郵便番号の形式をチェック
  validates :phone_number, format: { with: /\A\d{10,11}\z/ } # 電話番号の形式をチェック

  def save
    # 注文情報の保存
    order = Order.create(user_id: user_id, item_id: item_id)

    # 配送先情報の保存
    ShippingAddress.create(order_id: order.id, postal_code: postal_code, city: city, address: address, phone_number: phone_number)
  end
end
