class CreateCheckedHypotheses < ActiveRecord::Migration
  def change
    create_table :checked_hypotheses do |t|
      t.integer :user_id
      t.integer :exercise_hypothesis_id
    end
  end
end
