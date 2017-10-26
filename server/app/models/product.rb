class Product < ApplicationRecord
  belongs_to :category
  mount_base64_uploader :picture, PictureUploader
  validates :name, presence: true
end
