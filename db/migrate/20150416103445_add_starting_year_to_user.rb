class AddStartingYearToUser < ActiveRecord::Migration
  def change
    add_column :users, :starting_year, :integer
  end
end
