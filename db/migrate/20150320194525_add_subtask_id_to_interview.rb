class AddSubtaskIdToInterview < ActiveRecord::Migration
  def change
  	add_column :interviews, :subtask_id, :integer
  end
end
