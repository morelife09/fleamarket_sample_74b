class CreditCardsController < ApplicationController
  require "payjp"
  def new
    @card = CreditCard.where(user_id: current_user.id).first
      if @card.present?
        redirect_to action:"index"
      end
  end

  def create
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    if params[:card_token].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params[:card_token],
        metadata: {user_id: current_user.id}
      )
      @card = CreditCard.new(
        card_id: customer.default_card,
        customer_id: customer.id,
        user_id: current_user.id
      )
      if @card.save
        redirect_to action: "index"
      else
        render "new"
      end
    end
  end

  def index
    @card = CreditCard.where(user_id: current_user.id).first
    if @card.present?
      Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_info = customer.cards.retrieve(@card.card_id)
      @brand = @default_card_info.brand
      @exp_month = @default_card_info.exp_month.to_s
      @exp_year = @default_card_info.exp_year.to_s.slice(2,3)

      case @brand
      when "Visa"
        @card_image = "visa.svg"
      when "JCB"
        @card_image = "jcb.svg"
      when "MasterCard"
        @card_image = "mastercard.svg"
      when "American Express"
        @card_image = "american_express.svg"
      when "Diners Club"
        @card_image = "dinersclub.svg"
      when "Discover"
        @card_image = "discover.svg"
      end
    end
  end

  def destroy
    @card = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    @card.destroy
    redirect_to action: "index"
  end
end
