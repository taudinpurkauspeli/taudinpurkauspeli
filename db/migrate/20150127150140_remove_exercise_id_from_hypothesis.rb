class RemoveExerciseIdFromHypothesis < ActiveRecord::Migration
  def change
  	 remove_column :hypotheses, :exercise_id
  end
end
