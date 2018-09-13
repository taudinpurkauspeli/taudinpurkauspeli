class CreateHypotheses < ActiveRecord::Migration[5.1]
  def change
    create_table :hypotheses do |t|
      t.string :name
      t.integer :count
      t.integer :hypothesis_group_id
      
      t.timestamps null: false
    end
  end
end
