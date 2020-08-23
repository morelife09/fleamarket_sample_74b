class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item.images.build
    @parents = Category.roots
  end

  def create
    @item = Item.new(item_params)
    if  @item.save
       redirect_to items_path
    else
       render :new
    end
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
