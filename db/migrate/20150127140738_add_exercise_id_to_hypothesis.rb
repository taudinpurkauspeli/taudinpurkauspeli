class AddExerciseIdToHypothesis < ActiveRecord::Migration
  def change
    add_column :hypotheses, :exercise_id, :integer
  end
end
