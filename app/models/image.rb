class Image < ApplicationRecord
  belongs_to :listing

  has_attached_file :image, styles: {medium: "200x200", thumb: "100x100"}, default_url: "/images/cityline.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
