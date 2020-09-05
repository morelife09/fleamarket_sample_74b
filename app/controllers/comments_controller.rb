class CommentsController < ApplicationController
  before_action :set_item, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @item
    else
      flash[:alert] = "コメント出来ませんでした"
      redirect_to root_path
    end
  end

  def destroy
    if @comment.destroy
      redirect_to @item
    else
      flash[:alert] = "削除出来ませんでした"
      redirect_to root_path
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :item_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
