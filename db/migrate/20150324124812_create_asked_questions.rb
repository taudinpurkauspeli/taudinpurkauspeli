class CreateAskedQuestions < ActiveRecord::Migration
  def change
    create_table :asked_questions do |t|
      t.integer :user_id
      t.integer :question_id

      t.timestamps null: false
    end
  end
end