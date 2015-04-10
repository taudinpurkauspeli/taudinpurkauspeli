class AddImageIdToTaskText < ActiveRecord::Migration
  def change
    add_column :task_texts, :image_id, :integer
  end
end
