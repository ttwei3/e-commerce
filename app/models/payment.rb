class Payment < ApplicationRecord
  belongs_to :order

  validates :payment_amount, numericality: true
  validates :payment_intent_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id payment_amount payment_date order_id]
  end
end
