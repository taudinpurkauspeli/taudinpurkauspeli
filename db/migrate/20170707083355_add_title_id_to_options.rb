class AddTitleIdToOptions < ActiveRecord::Migration
  def change
    add_column :options, :title_id, :integer
  end
end
