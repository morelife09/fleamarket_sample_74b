class CreditCardsController < ApplicationController
  require "payjp"
  def new

  end

  def create
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    if params[:card_token].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        card: params[:card_token],
        metadata: {user_id: current_user.id}
      )
      @card = CreditCard.new(
        card_id: customer.default_card,
        customer_id: customer.id,
        user_id: current_user.id
      )
      @card.save
    end
  end
end
