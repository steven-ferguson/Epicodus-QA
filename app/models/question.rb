class Question < ActiveRecord::Base 
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  validates :content, presence: true
  validates :title, presence: true, length: { maximum: 100 }
end