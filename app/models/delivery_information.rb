class DeliveryInformation < ApplicationRecord
  belongs_to :user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  validates :prefecture_id, :delivery_family_name, :delivery_first_name, :delivery_family_name_furigana, :delivery_first_name_furigana, :postal_code, :city, :address ,presence: true
end
