class CreateExerciseHypotheses < ActiveRecord::Migration
  def change
    create_table :exercise_hypotheses do |t|
      t.integer :exercise_id
      t.integer :hypothesis_id
      t.string :explanation

      t.timestamps null: false
    end
  end
end
