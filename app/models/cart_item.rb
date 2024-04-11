class CartItem
  include ActiveModel::Model
  attr_reader :product_id
  attr_accessor :quantity

  validates :product_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  
  def initialize(product_id, quantity =1)
    @product_id = product_id
    @quantity = quantity
  end

  def increment_quantity(by_amount = 1)
    @quantity += by_amount
  end

  def product
    Product.find(product_id)
  end

  def total_price
    product = Product.find(product_id)
    product.price * quantity
  end
end