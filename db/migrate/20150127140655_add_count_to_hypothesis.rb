class AddCountToHypothesis < ActiveRecord::Migration
  def change
    add_column :hypotheses, :count, :integer
  end
end
