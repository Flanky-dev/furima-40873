class OrderShipping
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token, :user_id, :item_id

  # バリデーションの追加
  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number without hyphen' }
    validates :token, presence: true
    validates :user_id
    validates :item_id
  end

  def save
    # 購入情報を保存
    order = Order.create(user_id:, item_id:)
    # 配送先情報を保存
    ShippingAddress.create(
      postal_code:,
      prefecture_id:,
      city:,
      address:,
      building:,
      phone_number:,
      order_id: order.id
    )
  end
end
