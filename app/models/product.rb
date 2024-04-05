class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items

  has_one_attached :image

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[product_name price description stock_quantity image create_at update_at category_id]
  end

  def has_image?
    image.attached?
  end

  scope :newly_added, -> { where('created_at >= ?', 3.days.ago) }

  scope :recently_updated, -> { where('updated_at >= ? AND created_at < ?', 3.days.ago, 3.days.ago) }

end
