class Question < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :user
      t.string :content

      t.timestamps
    end
  end
end
