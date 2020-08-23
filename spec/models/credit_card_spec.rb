require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  it "has a valid factory of user" do
    user = @user
    expect(user).to be_valid
  end
  describe '#create' do
    it "is valid with customer_id, card_id and user_id" do
      user = @user
      credit_card = user.credit_cards.build(
        customer_id: "cus_1a1a1a1a1a1a1a",
        card_id: "car_1a1a1a1a1a1a1a",
        user_id: 1
      )
      expect(credit_card).to be_valid
    end
    it "is invalid without customer_id" do
      credit_card = CreditCard.new(
        customer_id: nil,
        card_id: "car_1a1a1a1a1a1a1a",
        user_id: 1
      )
      credit_card.valid?
      expect(credit_card.errors[:customer_id]).to include("can't be blank")
    end
    it "is invalid without card_id" do
      credit_card = CreditCard.new(
        customer_id: "cus_1a1a1a1a1a1a1a",
        card_id: nil,
        user_id: 1
      )
      credit_card.valid?
      expect(credit_card.errors[:card_id]).to include("can't be blank")
    end
    it "is invalid without user_id" do
      credit_card = CreditCard.new(
        customer_id: "cus_1a1a1a1a1a1a1a",
        card_id: "car_1a1a1a1a1a1a1a",
        user_id: nil
      )
      credit_card.valid?
      expect(credit_card.errors[:user_id]).to include("can't be blank")
    end
  end
end
