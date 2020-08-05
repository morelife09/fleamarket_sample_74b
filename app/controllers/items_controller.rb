class ItemsController < ApplicationController

  def index

  end

  def purchase
    @d_info = DeliveryInformation.find(current_user.id)
  end

end
