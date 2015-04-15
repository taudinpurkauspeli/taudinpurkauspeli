class AddImageIdToOption < ActiveRecord::Migration
  def change
    add_column :options, :image_id, :integer
  end
end
