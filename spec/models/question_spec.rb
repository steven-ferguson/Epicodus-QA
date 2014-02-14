require 'spec_helper'

describe Question do
  it { should belong_to :user }
  it { should have_many(:answers).dependent(:destroy) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :content }
  it { should have_many(:comments).dependent(:destroy) }
  it { should ensure_length_of(:title).is_at_most(100) }
end