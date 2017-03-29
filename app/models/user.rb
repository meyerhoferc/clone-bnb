class User < ApplicationRecord
  has_many :listings
  has_many :reservations
  has_many :roles, through: :user_roles
end
