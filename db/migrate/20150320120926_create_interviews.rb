class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.string :title
      t.integer :subtask_id
      t.timestamps null: false
    end
  end
end
