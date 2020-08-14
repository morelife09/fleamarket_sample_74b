class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    render "users/show"
  end

  def show
    @nickname = current_user.nickname
  end

end
