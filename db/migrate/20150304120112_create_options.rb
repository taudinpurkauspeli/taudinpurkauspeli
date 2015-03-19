class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :multichoice_id
      t.string :content
      t.string :explanation
      t.boolean :value

      t.timestamps null: false
    end
  end
end
