class ItemsController < ApplicationController

  def index
    render "items/item"
  end

  # params.require(:store).permit(:name, :address, :image, :image_cache)

end
