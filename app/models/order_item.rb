class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :payment_amount, numericality: true

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id order_id payment_amount product_id quantity updated_at]
  end
end
