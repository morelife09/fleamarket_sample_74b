class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories, only: [:show, :credit, :owner, :email, :logout]

  def show
    @nickname = current_user.id
  end

  def credit
  end

  def owner
    @d_info = DeliveryInformation.find(current_user.id)
  end

  def email
  end

  def logout
  end

  private
  def set_categories
  @parents = Category.where(ancestry: nil)
  end
  
end