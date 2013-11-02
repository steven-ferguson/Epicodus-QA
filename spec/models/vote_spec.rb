require 'spec_helper'

describe Vote do
  it { should belong_to :user }
  it { should belong_to :answer }
  it { should validate_uniqueness_of(:user_id).scoped_to(:answer_id) }
end
