class CreateSavedExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :saved_exercises do |t|
      t.integer :exercise_id
      t.integer :user_id
      t.integer :completion_percent
      t.text :description

      t.timestamps null: false
    end
  end
end
