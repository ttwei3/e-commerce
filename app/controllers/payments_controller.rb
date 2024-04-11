# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  before_action :set_order

  # 初始化创建支付意图
  def new
    intent = Stripe::PaymentIntent.create({
      amount: (@order.total_price * 100).to_i,
      currency: 'cad',
      metadata: { order_id: @order.id }
    })
    @client_secret = intent.client_secret

    # 为了确保 payment_intent_id 能够在 create 方法中使用，可以考虑立即存储它
    @payment = @order.build_payment(
      payment_amount: @order.total_price,
      payment_intent_id: intent.id
    )
    @payment.save
  end

  def create
    @payment = @order.payment  # 从订单中获取已经创建的支付记录

    if @payment.save
      render json: { client_secret: @client_secret }
    else
      render json: { error: 'Payment could not be processed', details: @payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def complete
    payment_intent_id = params[:payment_intent_id]  # 从请求参数中获取 payment_intent_id

    intent = Stripe::PaymentIntent.retrieve(payment_intent_id)
    if intent && intent.status == 'succeeded'
      @order.update(order_status: 'paid')
      render json: { success: true }
    else
      @order.update(order_status: 'unpaid')
      render json: { error: 'Invalid or Unsuccessful PaymentIntent', details: intent.status }, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = current_user.orders.find(params[:order_id])
  end
end
