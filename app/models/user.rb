class User < ApplicationRecord
  validates :email, uniqueness: true

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[first_name last_name email address phone_number role]
  end
end
