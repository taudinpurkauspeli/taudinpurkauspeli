class AddAnamnesisToExercises < ActiveRecord::Migration
  def change
	add_column :exercises, :anamnesis, :text
  end
end
