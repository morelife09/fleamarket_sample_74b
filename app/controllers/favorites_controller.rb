class FavoritesController < ApplicationController

  def create
    user=current_user
    item=Item.find(params[:item_id])
    if Favorite.create(user_id: user.id, item_id: item.id)
    redirect_to Item
    else
      redirect_to root_path
    end

  end

  def destroy
    user=current_user
    item=Item.find(params[:item_id])
    if favorite=Favorite.find_by(user_id: user.id, item_id: item.id)
      favorite.delete
      redirect_to users_path(current_user)
    else
      redirect_to root_path
    end
