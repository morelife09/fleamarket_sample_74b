class ItemsController < ApplicationController
  before_action :set_items, only: [:show, :purchase, :pay, :complete, :edit, :update]
  before_action :set_categories, only: [:index, :new, :create, :show]
  before_action :set_card, only: [:purchase, :pay]
  before_action :move_to_index, except: [:index, :show, :search]

  require "payjp"

  def index
    @items = Item.all.order("id DESC").limit(4)
    @parents = Category.where(ancestry: nil)
    @favorites = Favorite.all
  end

  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    if  @item.save
       redirect_to @item
    else
      redirect_to new_item_path
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user).order(created_at: :desc)
  end

  def search
    @parents = Category.where(ancestry: nil)
    @items = Item.search(params[:name])
  end

  def edit
    grandchild_category = @item.category
    child_category = grandchild_category.parent

    @category_parent_array = Category.where(ancestry: nil)
    @category_children_array = Category.where(ancestry: child_category.ancestry)
    @category_grandchildren_array = Category.where(ancestry: grandchild_category.ancestry)

  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      redirect_to edit_item_path
    end
  end

  def purchase
    @d_info = DeliveryInformation.find(current_user.id)
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


  def pay
    if @item.buyer_id.present?
      redirect_back(fallback_location: root_path)
    elsif @card.blank?
      redirect_to({controller: "credit_cards", action: "index"}, alert: "購入にはクレジットカードが必要です")
    else
      Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
      Payjp::Charge.create(
        amount: @item.price,
        customer: @card.customer_id,
        currency: 'jpy'
      )
      if @item.update(buyer_id: current_user.id)
        redirect_to action: "complete"
      else
        redirect_to @item
      end
    end
  end

  def complete

  end


  def destroy
    item = Item.includes(:seller,:category).find(params[:id])
    if item.seller_id == current_user.id && item.destroy #ログイン中はdestroyメソッドを使用し対象のitemsを削除する。
      render("items/destroy")
    else
      redirect_to root_path, alert: "削除が失敗しました"
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

  def set_card
    @card = CreditCard.find_by(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
