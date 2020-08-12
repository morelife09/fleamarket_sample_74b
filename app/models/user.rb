class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :first_name, :family_name, :first_name_furigana, :family_name_furigana, :birth_date ,presence: true
  has_many :credit_cards, dependent: :destroy
  has_one :delivery_information
  has_many :item_purchases, dependent: :destroy
  has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :selling_items, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item", dependent: :destroy
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"
end
