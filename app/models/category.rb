class Category < ApplicationRecord
  has_many :products
  
  def self.ransackable_attributes(auth_object = nil)
    ["category_name", "created_at", "id", "updated_at"]
  end
end
