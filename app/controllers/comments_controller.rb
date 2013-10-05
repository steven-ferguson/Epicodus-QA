class CommentsController < ApplicationController
  def new
    @comment = Comment.new(commentable_id: params[:commentable_id], commentable_type: params[:commentable_type])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to question_path(@comment.question) }
        format.js
      end
    else
      render 'new.js'
    end
  end

private
  def comment_params
    params.require(:comment).permit(:user_id, :commentable_id, :commentable_type, :content)
  end
end