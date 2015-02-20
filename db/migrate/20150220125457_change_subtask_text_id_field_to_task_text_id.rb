class ChangeSubtaskTextIdFieldToTaskTextId < ActiveRecord::Migration
  def change
  	rename_column :subtasks, :text_id, :task_text_id
  end
end
