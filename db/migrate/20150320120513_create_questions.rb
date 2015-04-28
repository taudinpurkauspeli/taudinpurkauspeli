class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :content
      t.boolean :required
      t.integer :question_group_id
      t.integer :interview_id
      t.timestamps null: false
    end
  end
end
