class CommentsController < ApplicationController
  def new
    @comment = Comment.new(commentable_id: params[:commentable_id], commentable_type: params[:commentable_type])
    if params[:commentable_type] == 'Question'
      @type = 'Question'
      @parent = Question.find(params[:commentable_id])
    else 
      @type = 'Answer'
      @parent = Answer.find(params[:commentable_id])
    end
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

  def destroy
    @comment = Comment.find(params[:id])
    if current_user = @comment.user
      @comment.destroy
      render 'delete.js'
    else
      redirect_to question_path(@comment.parent_question)
    end
  end

private
  def comment_params
    params.require(:comment).permit(:user_id, :commentable_id, :commentable_type, :content)
  end
end