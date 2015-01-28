class CreateHypotheses < ActiveRecord::Migration
  def change
    create_table :hypotheses do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
