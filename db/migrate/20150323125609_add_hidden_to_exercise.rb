class AddHiddenToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :hidden, :boolean
  end
end
