class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @nickname = current_user.id
  end

end