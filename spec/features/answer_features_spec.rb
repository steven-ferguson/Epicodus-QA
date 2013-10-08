require 'spec_helper'

feature "Answer a question" do 
  scenario "a user submits a valid answer", js: true do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    question = FactoryGirl.create(:question)
    visit question_path(question)
    click_link "Answer"
    fill_in "answer_content", :with => "I know everything"
    click_on "Post your answer"
    page.should have_content "I know everything"
  end
  
  scenario "a user submits an invalid answer", js: true do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    question = FactoryGirl.create(:question)
    visit question_path(question)
    click_link "Answer"
    click_on "Post your answer"
    page.should have_content "blank"
  end

  scenario 'a non-logged in user tries to submit an answer', js: true do 
    question = FactoryGirl.create(:question)
    visit question_path(question)
    click_link "Answer" 
    page.should have_content "Sign in"
  end
end

feature "Vote on an answer" do
  scenario "a user votes" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    question = FactoryGirl.create(:question)
    answer = question.answers.create(:user => question.user, :content => "Answer here")
    visit question_path(question)
    find(".fis-thumb-up").click
    page.should have_content "1"
  end

  scenario "non-logged in user tries to vote" do 
    question = FactoryGirl.create(:question)
    answer = question.answers.create(:user => question.user, :content => "Answer here")
    visit question_path(question)
    find(".fis-thumb-up").click
    page.should have_content "Sign in"
  end

  scenario "a user tries to vote on an answer they have already voted on" do 
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    question = FactoryGirl.create(:question)
    answer = question.answers.create(:user => question.user, :content => "Answer here")
    visit question_path(question)
    find(".fis-thumb-up").click
    find(".fis-thumb-up").click
    page.should have_content "can't"
  end 
end
















