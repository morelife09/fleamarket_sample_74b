class Item < ApplicationRecord
  belongs_to :seller, class_name: "User"
  has_one :buyer, class_name: "User"
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :category
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :size
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :delivery_days
  belongs_to_active_hash :brand
  validates_associated :images
  validates :images, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price,numericality: { only_integer: true,greater_than: 300, less_than: 999999}
end
