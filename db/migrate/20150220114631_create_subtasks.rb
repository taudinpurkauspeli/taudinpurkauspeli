class CreateSubtasks < ActiveRecord::Migration[5.1]
  def change
    create_table :subtasks do |t|
      t.integer :task_id
      t.integer :level

      t.timestamps null: false
    end
  end
end
