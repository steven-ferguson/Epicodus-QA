class AnswersController < ApplicationController 
  def new 
    @answer = current_user.answers.new(question_id: params[:question_id])
  end

  def create
    @answer = current_user.answers.new(answer_params)
    if @answer.save
      respond_to do |format|
        format.html { redirect_to question_path(@answer.question) }
        format.js
      end
    else 
      redirect_to @answer.question
    end

  end

private
  def answer_params 
    params.require(:answer).permit(:user_id, :question_id, :content)
  end
end