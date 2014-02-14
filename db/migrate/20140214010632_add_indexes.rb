class AddIndexes < ActiveRecord::Migration
  def change
    add_index :answers, :question_id
    add_index :answers, :user_id
    add_index :comments, :user_id
    add_index :comments, :commentable_id
    add_index :comments, :commentable_type
    add_index :questions, :user_id
    add_index :users, :admin
    add_index :votes, :answer_id
  end
end
