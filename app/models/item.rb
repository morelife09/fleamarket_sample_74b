class Item < ApplicationRecord
  belongs_to :seller, class_name: "User"
  has_one :buyer, class_name: "User"
  has_many :images, dependent: :destroy
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
  validates :images, :name, :description, :price, :seller_id, :category_id, :condition_id, :prefecture_id,
  :shipping_fee_id, :delivery_days_id, :brand_id, presence: true
  validates :price,numericality: { only_integer: true,greater_than: 300, less_than: 999999}
  validates :price,numericality: { only_integer: true,greater_than: 299, less_than: 1000000}
  has_many :comments
  has_many :favorites
  has_many :users, through: :favorites

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
