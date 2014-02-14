require 'spec_helper'

feature "Pagination" do 
  scenario "pagination on the questions index page" do 
    11.times { FactoryGirl.create(:question) }
    visit root_path
    page.should have_content "2"
  end
end




















