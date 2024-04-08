class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province
  has_many :orders

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, :last_name, :address, :city, :postal_code, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/ }
  validates :province_id, numericality: { only_integer: true, greater_than: 0 }

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[first_name last_name email address city postal_code phone_number role]
  end
end
