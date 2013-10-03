class AddContentColumnToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :content, :text
    Question.all.each { |question| question.update(:content => question.body)}
  end
end
