class FavoritesController < ApplicationController

  def create
    @item = Item.find(params[:id])
    @favorite = Favorite.new(user_id: current_user.id, item_id: @item.id)

    if @favorite.save
      redirect_to item_path(@item)
    end
  end

  def destroy
    @favotrite = Favorite.find(params[:item_id])
      if @favorite.delete
      redirect_to users_path(current_user)
    end
  end

end
