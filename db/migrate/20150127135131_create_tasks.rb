class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :exercise_id
      t.integer :level

      t.timestamps null: false
    end
  end
end
