class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :exercise_id
      t.integer :level

      t.timestamps null: false
    end
  end
end
