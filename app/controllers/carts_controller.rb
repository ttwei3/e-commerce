class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def index
    @cart = current_cart
    @cart_items = @cart.cart_items
  end

  def show
    @cart = current_cart
  end

  def update_item
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i

    cart = current_cart
    cart.update_product_quantity(product_id, quantity)
    session[:cart] = cart.serialize

    redirect_to carts_path
  end

  def remove_item
    product_id = params[:product_id].to_i

    cart = current_cart
    cart.remove_product(product_id)
    session[:cart] = cart.serialize

    redirect_to carts_path
  end

  def checkout
    redirect_to review_orders_path
  end

  private

  def current_cart
    session[:cart] ||= []
    cart_data = session[:cart]
    cart_data.is_a?(Array) ? Cart.new(cart_data) : Cart.new
  end
end
