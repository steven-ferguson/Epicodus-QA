class RemoveBodyColumnFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :body
  end
end
