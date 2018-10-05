class CreateOwnFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :own_files do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
