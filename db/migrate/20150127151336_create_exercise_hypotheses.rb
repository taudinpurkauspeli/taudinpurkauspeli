class CreateExerciseHypotheses < ActiveRecord::Migration[5.1]
  def change
    create_table :exercise_hypotheses do |t|
      t.integer :exercise_id
      t.integer :hypothesis_id
      t.integer :task_id
      t.string :explanation

      t.timestamps null: false
    end
  end
end
