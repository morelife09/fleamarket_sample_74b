class FavoritesController < ApplicationController

  def index
    @parents = Category.where(ancestry: nil)
    @favorites = Favorite.all
  end

  def show
    @user = User.find(params[:id])
    @item = @user.items
    @favorite_items = @user.favorite_items
  end

  def create
    @item = Item.find(params[:id])
    @favorites = Favorite.new(user_id: current_user.id, item_id: @item.id)
    if @favorites.save
      redirect_to item_path(@item)
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @favorites = Favorite.find_by(user_id: current_user.id, item_id: @item.id)
    if @favorites.delete
      redirect_to item_path(@item)
    end
  end

end
