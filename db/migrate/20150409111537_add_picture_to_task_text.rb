class AddPictureToTaskText < ActiveRecord::Migration
  def change
  	 add_attachment :task_texts, :picture
  	remove_attachment :task_texts, :picture
  end
end
