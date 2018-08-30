class CreateExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.boolean :hidden
      t.timestamps null: false
    end
  end
end
