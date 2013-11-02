require 'spec_helper'

feature "Post a question" do
  context 'a registered user' do 
    scenario "they successfully post a question" do 
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

    scenario "they submit an invalid question" do
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      visit root_path
      click_link "Ask a question"
      click_on "Post your question"
      page.should have_content 'blank'
    end
  end

  context 'a guest' do 
    scenario 'they can not visit the path directly' do 
      visit new_question_path
      page.should have_content 'You need to sign in'
    end

    scenario 'they can not submit a POST request directly' do 
      user = FactoryGirl.create(:user)
      page.driver.submit :post, questions_path(:question => {:user_id => user.id, :title => 'Cool Title', :content => "Words"}), {}
      page.should have_content 'You need to sign in'
    end
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
  before do 
    @question = FactoryGirl.create(:question)
  end

  scenario "an admin deletes a question" do 
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit question_path(@question)
    within("#question-title") { click_link("") }
    page.should_not have_content(@question.title)
    page.should have_content "successfully"
  end

  context 'a non-admin' do 
    before do 
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
    end

    scenario "they can't see a delete icon" do 
      visit question_path(@question)
      within('#question-title') { page.should_not have_css '.fi-trash' }
    end

    scenario "they can't submit a DELETE request directly" do 
      page.driver.submit :delete, question_path(:id => @question.id), {}
      page.should have_content 'Not authorized'
    end
  end
end




















