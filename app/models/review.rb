class Review < ApplicationRecord
  validates :title, :message, :stars, presence: true
  belongs_to :listing

  def listing_title
    listing.title
  end

  def host_email
    listing.user.email
  end
end
