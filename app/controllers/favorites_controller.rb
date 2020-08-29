class FavoritesController < ApplicationController

  def create
    @user = current_user.id
    @item = Item.find(params[:item_id])
    @favorite = Favorite.new(@user_id: user.id, @item_id: item.id)

    if @favorite.save
      redirect_to item_path(current_user)
    end

  end

  def destroy
    @favotrite = Favorite.find(params[:item_id])
      if @favorite.delete
      redirect_to users_path(current_user)
    end
