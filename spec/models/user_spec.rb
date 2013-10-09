require 'spec_helper'

describe User do
  it { should have_many :questions }
  it { should have_many :answers }
  it { should have_many :votes }
  it { should have_many :comments }

  it "can tell you if it is an admin" do 
    user = FactoryGirl.create(:admin)
    user.admin?.should eq true

    user_b = FactoryGirl.create(:user)
    user_b.admin?.should eq false
  end
end
