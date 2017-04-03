class User < ApplicationRecord
  has_secure_password

  validates :email, :first_name, :last_name, :phone_number, presence: true
  validates :email, :phone_number, uniqueness: true
  enum status: [:active, :inactive]


  has_many :listings
  has_many :reservations

  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :conversations, foreign_key: 'initiator_id'

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

  def recipient
    if conversation.initiator_id == current_user.id
      recipient = User.find(conversation.recipient_id)
    else
      recipient = User.find(conversation.initiator_id)
    end
  end
end
