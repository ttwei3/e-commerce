class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @cart = current_cart
    @tax_details = calculate_taxes(@user)
  end

  def review
    @cart = current_cart
    @cart_items = @cart.cart_items
    @tax_details = calculate_taxes(current_user)
  end
  
  private

  def current_cart
    session[:cart] ||= []
    cart_data = session[:cart]
    Cart.new(cart_data)
  end

  def calculate_taxes(user)
    province = user.province
    subtotal = @cart.subtotal_price

    gst = province.gst * subtotal
    pst = province.pst * subtotal
    hst = province.hst * subtotal
    total_tax = gst + pst + hst
    grand_total = subtotal + total_tax

    { gst: gst, pst: pst, hst: hst, total_tax: total_tax, grand_total: grand_total }
  end
end
