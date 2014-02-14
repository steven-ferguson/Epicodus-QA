require 'spec_helper'

feature "Post a question" do
  context 'a registered user' do
    background 'create user and login' do 
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
    end

    background "they submit an invalid question" do
      visit root_path
      click_link "Ask a question"
      click_on "Post your question"
      expect(page).to have_content 'blank'
    end

    scenario "they successfully post a question" do 
      visit root_path
      click_link "Ask a question"
      fill_in 'question_title', :with => "This is the title"
      fill_in 'question_content', :with => "Does this thing work?"
      click_on "Post your question"
      page.should have_content 'successfully'
      page.should have_content 'This is the title'
    end
  end

  context 'a guest' do 
    background 'they can not visit the path directly' do 
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