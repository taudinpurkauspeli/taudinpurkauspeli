class CreateLogEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :log_entries do |t|
      t.integer :user_id
      t.string :controller
      t.string :action
      t.text :params
      t.integer :exercise_id
      t.integer :task_id
      t.text :exhyp_ids
      t.datetime :datetime
      t.string :request_path
      t.string :ip
      t.string :method
      t.string :response_path

      t.timestamps null: false
    end
  end
end
