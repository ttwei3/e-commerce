class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province

  has_many :products, through: :order_items

  has_many :order_items, dependent: :destroy
  has_one :payment, dependent: :destroy

  validates :total_price, numericality: true

  enum order_status: { new: 'new', paid: 'paid', unpaid: 'unpaid', shipped: 'shipped', cancelled: 'cancelled' }, _prefix: :status

  def self.ransackable_associations(auth_object = nil)
    super + ['payment']
  end

  def self.ransackable_attributes(auth_object = nil)
    super - ['id', 'created_at', 'updated_at']
  end

  def items_total_price
    order_items.sum("quantity * payment_amount") || 0
  end

  def calculate_total_tax
    (total_price || 0) - items_total_price
  end
end
