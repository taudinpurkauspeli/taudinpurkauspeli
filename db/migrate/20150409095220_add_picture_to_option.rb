class AddPictureToOption < ActiveRecord::Migration
  def change
  	add_attachment :options, :picture
  	remove_attachment :options, :picture
  end
end
