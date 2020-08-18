class UsersController < ApplicationController
  before_action :authenticate_user!

  # def index
  # end

  def show
    @nickname = current_user.nickname
  end

end
