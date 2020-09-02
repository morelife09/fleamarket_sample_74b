class FavoritesController < ApplicationController
  before_action :set_items, only: [:show, :create, :destroy]

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
    end
  end

  def destroy
    @favorites = Favorite.find_by(user_id: current_user.id, item_id: @item.id)
    if @favorites.delete
      redirect_to item_path(@item)
    end
  end

  private
  def set_items
    @item = Item.includes(:seller,:category).find(params[:id])
  end

end
