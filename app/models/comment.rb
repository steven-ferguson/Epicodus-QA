class Comment < ActiveRecord::Base 
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  validates :content, presence: true
  validates :user_id, presence: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true

  
  def question
    if commentable_type == "Question"
      self.commentable
    else
      self.commentable.question
    end    
  end

  def parent_type 
    commentable_type
  end
end