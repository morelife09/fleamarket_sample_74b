class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    render "items/item"
  end

  def new
    @item = Item.new
    @item.images.build
    @parents = Category.where(ancestry: nil)
  end

  def create
    @parents = Category.where(ancestry: nil)
    @item = Item.new(item_params)
    if  @item.save
       redirect_to items_path
    else
       render :new
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  def purchase
    @d_info = DeliveryInformation.find(current_user.id)
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




end
