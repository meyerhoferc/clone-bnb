class User < ApplicationRecord
  has_secure_password

  validates :email, :first_name, :last_name, :phone_number, presence: true
  validates :email, :phone_number, uniqueness: true
  enum status: [:active, :inactive]

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/cityline.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


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

  def admin?
    roles.exists?(title: "admin")
  end

  def update_role(role)
    if role == "host"
      roles.create(title: "host")
    end
  end
end
