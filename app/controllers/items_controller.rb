class ItemsController < ApplicationController

  def index
    render "items/item"
  end

  def purchase
    @d_info = DeliveryInformation.find(current_user.id)
  end

end
