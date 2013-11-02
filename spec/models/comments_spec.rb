require 'spec_helper'

describe Comment do
  it { should belong_to :user }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :content }
  it { should validate_presence_of :commentable_id }
  it { should validate_presence_of :commentable_type }

  it "can find the question associated with it" do 
    question = FactoryGirl.create(:question)
    answer = FactoryGirl.create(:answer, question: question)
    comment = answer.comments.create(user: FactoryGirl.create(:user), content: "This")
    comment.question.should eq question
  end
end