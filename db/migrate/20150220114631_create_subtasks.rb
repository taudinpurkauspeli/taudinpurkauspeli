class CreateSubtasks < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
      t.integer :task_id
      t.integer :text_id

      t.timestamps null: false
    end
  end
end
