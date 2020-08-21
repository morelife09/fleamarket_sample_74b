class CreditCard < ApplicationRecord
  belongs_to :user
  validates :user_id, :customer_id, :card_id, presence: true
end
