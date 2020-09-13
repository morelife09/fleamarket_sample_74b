class FavoritesController < ApplicationController
  before_action :set_items, only: [:show, :create, :destroy]
  before_action :set_search, only: [:index, :show]

  def index
    @parents = Category.where(ancestry: nil)
    @favorites = Favorite.all
  end

  def show
  end

  def create
    @favorites = Favorite.new(user_id: current_user.id, item_id: @item.id)
    if @favorites.save
      redirect_to item_path(@item)
    else
      redirect_to item_path(@item)
    end
  end

  def destroy
    @favorites = Favorite.find_by(user_id: current_user.id, item_id: @item.id)
    if @favorites.delete
      redirect_to item_path(@item)
    else
      redirect_to item_path(@item)
    end
  end

  def search
    @parents = Category.where(ancestry: nil)
    if params[:q].present?
      @q = Item.ransack(search_params)
      @items = @q.result(distinct: true)
      if params[:q][:name_or_description_cont].present?
        @title = @q.name_or_description_cont
        @keyword = @title
      end
      if params[:q][:brand_id_in].present?
        brand = Brand.find(params[:q][:brand_id_in])
        @brand = brand.name
        @keyword = @brand
      end
      if @title.present? && @brand.present?
        @keyword = @title + " " + @brand
      end
    else
      params[:q] = { sorts: 'updated_at DESC' }
      @q = Item.ransack()
      @items = Item.all
    end

    if params[:id]
      @price_range = PriceRange.find(params[:id])
        respond_to do |format|
          format.json { render json: {id: @price_range.id, min: @price_range.min, max: @price_range.max}}
        end
    end
  end

  private
  def set_items
    @item = Item.includes(:seller,:category).find(params[:id])
  end

end
