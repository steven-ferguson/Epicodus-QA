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
  scenario "a successfully submits and answer" do
    question = FactoryGirl.create(:question)
    visit root_path
    click_on question.title
    click_on "Answer"
    fill_in "answer_content", :with => "I know everything"
    click_on "Submit"
    page.should have_content "I know everything"
  end
end

