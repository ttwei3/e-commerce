class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province

  has_many :order_items

  validates :total_price, numericality: true
end
