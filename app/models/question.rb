class Question < ActiveRecord::Base 
  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
  validates :content, presence: true
  validates :title, presence: true, length: { maximum: 100 }
end