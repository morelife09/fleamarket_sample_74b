class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.all
  end

  def create
    @item = Item.find(params[:id])
    @favorites = Favorite.new(user_id: current_user.id, item_id: @item.id)
    if @favorite.save
      redirect_to item_path(@item)
    end
  end

  def destroy
    @favorites = Favorite.find(params[:item_id])
      if @favorites.delete
      redirect_to users_path(current_user)
    end
  end

end
