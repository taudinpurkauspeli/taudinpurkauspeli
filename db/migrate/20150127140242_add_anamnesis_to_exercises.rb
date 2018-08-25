class AddAnamnesisToExercises < ActiveRecord::Migration[5.1]
  def change
	add_column :exercises, :anamnesis, :text
  end
end
