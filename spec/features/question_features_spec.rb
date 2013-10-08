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

feature "Edit a comment" do
  let(:user) { FactoryGirl.create :user }
  let(:question) { FactoryGirl.create(:question) }
  before do 
    visit root_path
    click_link "Sign in"
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_on "Submit"
  end

  scenario "successfully", js: true do
    comment = question.comments.create(user: user, content: "This is a comment")
    visit question_path(question)
    find(".fi-edit").trigger('click')
    fill_in 'comment_content', :with => " Additional text"
    click_on('Update')
    page.should have_content "Additional text"
  end
end

feature "Pagination" do 
  scenario "pagination on the questions index page" do 
    11.times { FactoryGirl.create(:question) }
    visit root_path
    page.should have_content "2"
  end
end




















