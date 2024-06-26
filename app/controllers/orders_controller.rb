class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @cart = current_cart
    @tax_details = calculate_taxes(@user)
    @orders = current_user.orders.includes(:order_items => :product).order(created_at: :desc)
  end

  def review
    @cart = current_cart
    @cart_items = @cart.cart_items
    @tax_details = calculate_taxes(current_user)
  end

  def create
    @cart = current_cart
    @cart_items = @cart.cart_items
    @order = current_user.orders.build(order_params)
    @order.province_id = current_user.province_id
    @tax_details = calculate_taxes(current_user)
    @cart_items.each do |cart_item|
      @order.order_items.build(
        product: cart_item.product,
        quantity: cart_item.quantity,
        payment_amount: cart_item.product.price
      )
    end
    @order.total_price = @tax_details[:grand_total]

    if @order.save
      session.delete(:cart)
      redirect_to new_order_payment_path(@order)
    else
      render :review
    end
  end

  def cancel
    @order = current_user.orders.find(params[:id])
    if @order.status_new?
      @order.status_cancelled!
      flash[:notice] = 'Order was successfully cancelled.'
    else
      flash[:alert] = 'Only new orders can be cancelled.'
    end
    redirect_to orders_path
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
    unless @order
      redirect_to orders_path, alert: "Order not found."
    end
  end

  private

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

  def order_params
    params.require(:order).permit(:total_price)
  end
end