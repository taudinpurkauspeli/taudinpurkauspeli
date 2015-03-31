class CreateAskedQuestions < ActiveRecord::Migration
  def change
    create_table :asked_questions do |t|

      t.timestamps null: false
    end
  end
end
