class Cart
  attr_reader :cart_items

  def initialize(cart_items = [])
    @cart_items = cart_items.map { |item|
      CartItem.new(item["product_id"], item["quantity"])
    }
  end

  def add_product(product_id, quantity = 1)
    cart_item = cart_items.find { |item| item.product_id == product_id }
    if cart_item
      cart_item.increment_quantity(quantity)
    else
      @cart_items << CartItem.new(product_id, quantity)
    end
  end

  def update_product_quantity(product_id, quantity)
    cart_item = cart_items.find { |item| item.product_id == product_id }
    if cart_item
      cart_item.quantity = quantity
    end
  end

  def remove_product(product_id)
    @cart_items.reject! { |item| item.product_id == product_id }
  end

  def serialize
    @cart_items.map { |item| {"product_id" => item.product_id, "quantity" => item.quantity} }
  end
end
