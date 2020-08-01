class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :items_purchase
  has_many :images , dependent: :destroy
  belongs_to :category
  has_many :brands
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :size
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :delivery_days
  validates :image, presence: true, unless: :image
  
end
