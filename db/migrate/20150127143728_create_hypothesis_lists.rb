class CreateHypothesisLists < ActiveRecord::Migration
  def change
    create_table :hypothesis_lists do |t|
      t.integer :hypothesis_id
      t.integer :exercise_id
      t.string :explanation

      t.timestamps null: false
    end
  end
end
