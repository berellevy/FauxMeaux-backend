class Api::V1::CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.user = current_user
    if comment.save
      render json: comment.with_user
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id)  
  end
  
end
