# app/models/static_page.rb
class StaticPage < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "identifier", "content", "created_at", "updated_at"]
  end

  def to_param
    identifier
  end
end
