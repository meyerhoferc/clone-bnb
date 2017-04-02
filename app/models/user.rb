class User < ApplicationRecord
  has_secure_password

  validates :email, :first_name, :last_name, :phone_number, presence: true
  validates :email, :phone_number, uniqueness: true

  has_many :listings
  has_many :reservations

  has_many :user_roles
  has_many :roles, through: :user_roles

  def traveler?
    roles.exists?(title: "traveler")
  end

  def host?
    roles.exists?(title: "host")
  end

  def update_role(role)
    if role == "host"
      roles.create(title: "host")
    end
  end
end
