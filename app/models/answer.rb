class Answer < ActiveRecord::Base 
  belongs_to :user
  belongs_to :question
  has_many :votes, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  validates :content, presence: true
end