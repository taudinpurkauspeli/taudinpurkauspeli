class AddPrerequisiteForExerciseHypothesis < ActiveRecord::Migration
  def change
    add_column :exercise_hypotheses, :task_id, :integer
  end
end
