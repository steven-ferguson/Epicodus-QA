require 'spec_helper'

feature "Comment on a question" do 
  before do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    question = FactoryGirl.create(:question)
    visit question_path(question)
  end

  scenario "a user successfully posts a comment", js: true do 
    click_link "Improve this question"
    fill_in 'comment_content', with: "This is my comment"
    click_on "Post your comment"
    page.should have_content "successfully"
    page.should have_content "This is my comment"
  end

  scenario "unsuccessfully posting a comment", js: true do 
    click_link "Improve this question"
    click_on "Post your comment"
    page.should have_content "can't"
  end
end

feature "Comment on an answer" do
  before do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    question = FactoryGirl.create(:question)
    FactoryGirl.create(:answer, question: question)
    visit question_path(question)
  end

  scenario "successfully posting a comment", js: true do 
    click_on "Comment"
    fill_in 'comment_content', with: "This is my comment"
    click_on "Post your comment"
    page.should have_content "This is my comment"
  end

  scenario "invalid comment", js: true do 
    click_on "Comment"
    click_on "Post your comment"
    page.should have_content "can't"
    page.should_not have_content "successfully"
  end
end

feature "Edit a comment" do
  let(:question) { FactoryGirl.create(:question) }

  scenario "a user submits a valid edit on their comment of a question", js: true do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    comment = question.comments.create(user: user, content: "This is a comment")
    visit question_path(question)
    find(".fi-edit").trigger('click')
    fill_in 'comment_content', :with => " Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    click_on('Update')
    page.should have_content "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
  end

  scenario "a user submits a valid edit on their comment of an answer", js: true do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    answer = FactoryGirl.create(:answer, question: question)
    comment = answer.comments.create(user: user, content: "This is a comment")
    visit question_path(question)
    find(".fi-edit").trigger('click')
    fill_in 'comment_content', :with => " Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    click_on('Update')
    page.should have_content "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book." 
  end
end

feature "Delete a comment" do 
 let(:question) { FactoryGirl.create(:question) }

  scenario "successfully", js: true do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    comment = question.comments.create(user: user, content: "This is a comment")
    visit question_path(question)
    find(".fi-trash").trigger('click')
    page.should_not have_content "This is a comment"
  end

  scenario "a user visits a question page with no comments that they have written" do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    comment = question.comments.create(user: FactoryGirl.create(:user), content: "This is a comment")
    visit question_path(question)
    page.should_not have_css('.fi-trash')
  end
end
