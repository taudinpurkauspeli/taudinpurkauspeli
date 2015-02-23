class AddSubtaskIdToTaskText < ActiveRecord::Migration
  def change
  	add_column :task_texts, :subtask_id, :integer
  end
end
