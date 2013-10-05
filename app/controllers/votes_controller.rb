class VotesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @vote = current_user.votes.new(vote_params)
    if @vote.save
      redirect_to @vote.answer.question 
    else
      redirect_to @vote.answer.question, alert: "You can't vote twice on the same answer."
    end
  end

private
  def vote_params
    params.require(:vote).permit(:answer_id, :user_id)
  end
end