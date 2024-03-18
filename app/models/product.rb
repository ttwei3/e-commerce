class Product < ApplicationRecord
  belongs_to :category

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[product_name price description stock_quantity image create_at update_at category_id]
  end
end
