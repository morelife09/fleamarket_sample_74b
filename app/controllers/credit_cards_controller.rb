class CreditCardsController < ApplicationController
  require "payjp"
  before_action :set_card, only: [:new, :index, :destroy]
  before_action :set_key, only: [:create, :destroy]

  def new
    if @card.present?
      redirect_to action:"index"
    end
  end

  def create
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
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy
      redirect_to({action: "index"}, notice: "削除しました")
    else
      redirect_to({action: "index"}, alert: "削除できませんでした")
    end
  end

  private

  def set_card
    @card = CreditCard.find_by(user_id: current_user.id)
  end

  def set_key
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
  end
end
