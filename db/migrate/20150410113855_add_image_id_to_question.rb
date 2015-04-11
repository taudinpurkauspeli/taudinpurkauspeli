class AddImageIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :image_id, :integer
  end
end
