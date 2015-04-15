class CreateConclusions < ActiveRecord::Migration
  def change
    create_table :conclusions do |t|
      t.string :title
      t.string :content
      t.integer :subtask_id
      t.integer :exercise_hypothesis_id

      t.timestamps null: false
    end
  end
end
