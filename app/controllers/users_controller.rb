class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories, only: [:show, :credit, :owner, :email, :logout]
  before_action :set_search

  def show
    user = User.find(params[:id])
    @nickname = current_user.nickname
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
