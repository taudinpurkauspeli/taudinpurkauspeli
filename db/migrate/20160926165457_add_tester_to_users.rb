class AddTesterToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tester, :boolean, default: false
  end
end
