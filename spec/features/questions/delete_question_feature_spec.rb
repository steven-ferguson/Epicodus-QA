require 'spec_helper'

feature "Delete a question" do 
  scenario "an admin deletes a question" do
    question = FactoryGirl.create(:question) 
    user = FactoryGirl.create(:admin)
    login_as(user, :scope => :user)
    visit question_path(question)
    within("#question-title") { click_link("") }
    page.should_not have_content(question.title)
    page.should have_content "successfully"
  end

  context 'a non-admin' do 
    background 'create question and user' do 
      @question = FactoryGirl.create(:question)
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
    end

    background 'visit the question#show page' do 
      visit question_path(@question)
    end

    background "they can't see a delete icon" do 
      within('#question-title') { page.should_not have_css '.fi-trash' }
    end

    scenario "they can't submit a DELETE request directly" do 
      page.driver.submit :delete, question_path(:id => @question.id), {}
      page.should have_content 'Not authorized'
    end
  end
end
