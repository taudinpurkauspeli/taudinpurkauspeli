class AddPictureToExercise < ActiveRecord::Migration
  def self.up
    add_attachment :exercises, :picture
  end

  def self.down
    remove_attachment :exercises, :picture
  end
end
