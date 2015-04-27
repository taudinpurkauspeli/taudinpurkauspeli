class RemoveImages < ActiveRecord::Migration
  def change
    remove_column :exercises, :image_id
    remove_column :options, :image_id
    remove_column :task_texts, :image_id
    remove_column :questions, :image_id
    drop_table :images
  end
end
