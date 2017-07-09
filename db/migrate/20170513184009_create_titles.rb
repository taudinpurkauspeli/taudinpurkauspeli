class CreateTitles < ActiveRecord::Migration
  def change
    create_table :titles do |t|
      t.string :text
      t.integer :bank_id

      t.timestamps null: false
    end
  end
end
