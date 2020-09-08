class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  validates :nickname, :first_name, :family_name, :first_name_furigana, :family_name_furigana, :birth_date ,presence: true
  has_many :credit_cards, dependent: :destroy
  has_one :delivery_information
  has_many :item_purchases, dependent: :destroy
  has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :selling_items, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item", dependent: :destroy
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"
  has_many :sns_credentials
  has_many :comments
  has_many :favorites
  has_many :items, through: :favorites
  has_many :likes

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
