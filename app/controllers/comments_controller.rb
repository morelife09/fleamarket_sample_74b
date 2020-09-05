class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def create
    @item = Item.find(params[:item_id])
    @comment = Comment.new(comment_params)
    comment = Comment.create(comment_params)
    redirect_to @item
  end

  def destroy
    @item = Item.find(params[:item_id])
    @comment.destroy
    redirect_to @item
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :item_id).merge(user_id: current_user.id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
