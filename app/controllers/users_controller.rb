class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @nickname = current_user.id
    @parents = Category.where(ancestry: nil)
  end

  def credit
    @parents = Category.where(ancestry: nil)
  end

end