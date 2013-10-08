require 'spec_helper'

describe Comment do
  it { should belong_to :user }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :commentable_id }
  it { should validate_presence_of :commentable_type }

  it "can find the question associated with it" do 
    question = FactoryGirl.create(:question)
    answer = FactoryGirl.create(:answer, question: question)
    comment = answer.comments.create(user: FactoryGirl.create(:user), content: "This")
    comment.question.should eq question
  end

  it "tells you whether its parent is a question or an answer" do 
    question = FactoryGirl.create(:question)
    comment_a = question.comments.create(user: question.user)
    comment_a.parent_type.should eq "Question"

    answer = FactoryGirl.create(:answer)
    comment_b = answer.comments.create(user: question.user)
    comment_b.parent_type.should eq "Answer"
  end
end