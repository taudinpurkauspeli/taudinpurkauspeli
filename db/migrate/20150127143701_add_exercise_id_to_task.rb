class AddExerciseIdToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :exercise_id, :integer
  end
end
