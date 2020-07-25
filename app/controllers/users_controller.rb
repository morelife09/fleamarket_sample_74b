class UsersController < ApplicationController

  before_action :set_user, only: [:show, :mypage]

  def show
  end

  def mypage
  end

  private

  def set_user
    @user = User.find([:id])
  end
end
