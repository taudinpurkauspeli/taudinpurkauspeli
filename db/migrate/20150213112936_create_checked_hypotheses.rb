class CreateCheckedHypotheses < ActiveRecord::Migration[5.1]
  def change
    create_table :checked_hypotheses do |t|
      t.integer :user_id
      t.integer :exercise_hypothesis_id
    end
  end
end
