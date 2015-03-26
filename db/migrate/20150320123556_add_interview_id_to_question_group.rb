class AddInterviewIdToQuestionGroup < ActiveRecord::Migration
  def change
  	add_column :question_groups, :interview_id, :integer
  end
end
