require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  let(:user) { nil } 
  subject(:ability) { Ability.new(user) }

  context 'an admin' do 
    let(:user) { FactoryGirl.create(:admin) }
    it { should be_able_to :manage, :all }
  end

  context 'a registered user' do 
    let(:user) { FactoryGirl.create(:user) }
    it { should be_able_to :read, :all }
    it { should be_able_to :create, Comment.new }
    it { should be_able_to :update, FactoryGirl.create(:comment_to_question, user: user) }
    it { should be_able_to :destroy, FactoryGirl.create(:comment_to_question, user: user) }
  end
end