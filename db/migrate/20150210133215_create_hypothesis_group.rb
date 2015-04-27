class CreateHypothesisGroup < ActiveRecord::Migration
  def change
    create_table :hypothesis_groups do |t|
      t.string :name
    end
  end
end
