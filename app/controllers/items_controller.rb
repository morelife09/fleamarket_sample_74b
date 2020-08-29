class ItemsController < ApplicationController
  before_action :set_items, only: [:show, :edit, :update]

  def index
    @parents = Category.where(ancestry: nil)
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
       redirect_to root_path
    else
       render :new
    end
  end

  def show
    @parents = Category.where(ancestry: nil)
  end

  def edit
    grandchild_category = @item.category
    child_category = grandchild_category.parent


    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent
    end
    

    @category_children_array = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children_array << children
    end

    @category_grandchildren_array = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren_array << grandchildren
    end
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
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
  
  def set_items
    @item = Item.includes(:seller,:category).find(params[:id])
  end

end
