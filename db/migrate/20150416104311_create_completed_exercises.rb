class CreateCompletedExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :completed_exercises do |t|
      t.integer :user_id
      t.integer :exercise_id

      t.timestamps null: false
    end
  end
end
