class AddHypothesisGroupIdToHypothesis < ActiveRecord::Migration
  def change
    add_column :hypotheses, :hypothesis_group_id, :integer
  end
end
