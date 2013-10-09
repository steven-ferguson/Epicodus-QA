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
    login_as(user, :scope => :user)
    visit root_path
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

feature "Pagination" do 
  scenario "pagination on the questions index page" do 
    11.times { FactoryGirl.create(:question) }
    visit root_path
    page.should have_content "2"
  end
end

feature "Delete a question" do 
  scenario "an admin deletes a comment" do 
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    question = FactoryGirl.create(:question)
    visit question_path(question)
    find(".fi-trash").click
    page.should_not have_content(question.title)
    page.should have_content "successfully"
  end
end




















