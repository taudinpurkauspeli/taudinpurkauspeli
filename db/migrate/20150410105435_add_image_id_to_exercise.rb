class AddImageIdToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :image_id, :integer
  end
end
