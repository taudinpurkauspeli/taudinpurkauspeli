class CreateCompletedSubtasks < ActiveRecord::Migration[5.1]
  def change
    create_table :completed_subtasks do |t|
      t.integer :subtask_id
      t.integer :user_id
    end
  end
end
