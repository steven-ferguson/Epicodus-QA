require 'spec_helper'

feature "View a question" do 
  scenario "a user clicks on the question" do 
    question = FactoryGirl.create(:question)
    visit root_path
    click_on question.title
    page.should have_content(question.content)
  end
end