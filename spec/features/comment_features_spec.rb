require 'spec_helper'

feature "Comment on a question" do 
  before do 
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign in"
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_on "Submit"
  end

  scenario "a user successfully posts a comment", js: true do 
    question = FactoryGirl.create(:question)
    visit question_path(question)
    click_link "Improve this question"
    fill_in 'comment_content', with: "This is my comment"
    click_on "Post your comment"
    page.should have_content "successfully"
    page.should have_content "This is my comment"
  end

  scenario "unsuccessfully posting a comment", js: true do 
    question = FactoryGirl.create(:question)
    visit question_path(question)
    click_link "Improve this question"
    click_on "Post your comment"
    page.should have_content "can't"
  end
end

feature "Comment on an answer" do
  scenario "successfully posting a comment", js: true do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    question = FactoryGirl.create(:question)
    FactoryGirl.create(:answer, question: question)
    visit question_path(question)
    click_on "Comment"
    fill_in 'comment content', with: "This is my comment"
    click_on "Post your comment"
    page.should have_content "This is my comment"
  end
end