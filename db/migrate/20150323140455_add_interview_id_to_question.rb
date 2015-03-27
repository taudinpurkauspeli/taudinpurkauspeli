class AddInterviewIdToQuestion < ActiveRecord::Migration
  def change
  	add_column :questions, :interview_id, :integer
  end
end
