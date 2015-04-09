class AddPictureToQuestion < ActiveRecord::Migration
  def change
  	add_attachment :questions, :picture
  	remove_attachment :questions, :picture
  end
end
