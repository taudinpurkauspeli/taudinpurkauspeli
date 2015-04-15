class CreateConclusions < ActiveRecord::Migration
  def change
    create_table :conclusions do |t|
      t.string :title
      t.string :content

      t.timestamps null: false
    end
  end
end
