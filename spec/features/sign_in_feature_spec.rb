require 'spec_helper'

feature 'Sign in' do 
  scenario 'they successfully sign in' do 
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign in"
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_on "Submit"
    expect(page).to have_content 'successfully'
  end
end