class QuestionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[:notice] = "Your question has been successfully posted!"
      redirect_to root_path
    else
      render "new"
    end
  end

  def show
    @question = Question.find(params[:id])
  end

private

  def question_params
    params.require(:question).permit(:content, :user_id, :title)
  end
end