class CreateHypothesisGroup < ActiveRecord::Migration
  def change
    create_table :hypothesis_groups do |t|
      t.string :name
      t.integer :hypothesis_group_id
    end
  end
end
