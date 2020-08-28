class ItemsController < ApplicationController
  before_action :set_items, only: [:show, :purchase]
  before_action :set_categories, only: [:index, :new, :create, :show]

  require "payjp"

  def index
  end

  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    if  @item.save
       redirect_to items_path
    else
       render :new
    end
  end

  def show
  end

  def purchase
    @d_info = DeliveryInformation.find(current_user.id)
    @card = CreditCard.find_by(user_id: current_user.id)
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

  def get_category
    if params[:parent_id]
      @children = Category.find(params[:parent_id]).children
    elsif params[:child_id]
      @grandchildren = Category.find(params[:child_id]).children
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :description, :prefecture_id, :seller_id,
    :buyer_id, :condition_id, :category_id, :size_id, :shipping_fee_id,
     :delivery_days_id, :brand_id,
     images_attributes: [:src, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_items
    @item = Item.includes(:seller,:category).find(params[:id])
  end

  def set_categories
    @parents = Category.where(ancestry: nil)
  end
end
