class AddBodyToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :body, :text
    Question.all.each { |question| question.update(body: question.content) }
  end
end
