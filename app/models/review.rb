class Review < ApplicationRecord
  validates :title, :message, :stars, presence: true
  belongs_to :listing
end
