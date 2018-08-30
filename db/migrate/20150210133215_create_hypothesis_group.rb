class CreateHypothesisGroup < ActiveRecord::Migration[5.1]
  def change
    create_table :hypothesis_groups do |t|
      t.string :name
    end
  end
end
