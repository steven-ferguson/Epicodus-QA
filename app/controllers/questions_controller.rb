class QuestionsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @questions = Question.page(params[:page]).per_page(7)
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

  def destroy 
    @question = Question.find(params[:id])
    authorize! :delete, @question
    @question.destroy
    redirect_to root_path, notice: "Question successfully deleted."
  end

private

  def question_params
    params.require(:question).permit(:content, :user_id, :title)
  end
end