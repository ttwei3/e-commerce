# app/models/static_page.rb
class StaticPage < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :identifier, presence: true, uniqueness: true
  
  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "identifier", "content", "created_at", "updated_at"]
  end

  def to_param
    identifier
  end
end
