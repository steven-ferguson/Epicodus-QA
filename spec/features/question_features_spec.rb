require 'spec_helper'

feature "Post a question" do 
  scenario "a user successfully posts a question" do 
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign in"
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_on "Submit"
    click_link "Ask a question"
    fill_in 'question_title', :with => "This is the title"
    fill_in 'question_content', :with => "Does this thing work?"
    click_on "Post your question"
    page.should have_content 'successfully'
    page.should have_content 'This is the title'
  end

  scenario "a user does not submit a valid question" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign in"
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_on "Submit"
    click_link "Ask a question"
    click_on "Post your question"
    page.should have_content 'blank'
  end
end

feature "View a question" do 
  scenario "a user clicks on the question" do 
    question = FactoryGirl.create(:question)
    visit root_path
    click_on question.title
    page.should have_content(question.content)
  end
end

feature "Answer a question" do
  before do 
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign in"
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_on "Submit"
  end
  
  scenario "a user successfully submits an answer", js: true do
    question = FactoryGirl.create(:question)
    visit question_path(question)
    click_link "Answer"
    fill_in "answer_content", :with => "I know everything"
    click_on "Post your answer"
    page.should have_content "I know everything"
  end
  
  scenario "a user unsuccessfully submits an answer", js: true do
    question = FactoryGirl.create(:question)
    visit question_path(question)
    click_link "Answer"
    click_on "Post your answer"
    page.should have_content "blank"
  end
end

feature "Vote on an answer" do
  before do 
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign in"
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_on "Submit"
  end

  scenario "a user votes on an answer" do
    question = FactoryGirl.create(:question)
    answer = question.answers.create(:user => question.user, :content => "Answer here")
    visit question_path(question)
    find(".fis-thumb-up").click
    page.should have_content "1"
  end
end

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
end

























