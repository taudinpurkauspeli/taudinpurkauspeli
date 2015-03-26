class ChangeSubtaskTaskTextIdToLevel < ActiveRecord::Migration
  def change
    rename_column :subtasks, :task_text_id, :level
  end
end
