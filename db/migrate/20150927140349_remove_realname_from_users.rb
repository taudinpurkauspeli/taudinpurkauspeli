class RemoveRealnameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :realname, :string
  end
end
