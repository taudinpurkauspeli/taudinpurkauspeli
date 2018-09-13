class AddTitleIdToOptions < ActiveRecord::Migration[5.1]
  def change
    add_column :options, :title_id, :integer
  end
end
