class AddUserIdToAskedQuestion < ActiveRecord::Migration
  def change
  	add_column :asked_questions, :user_id, :integer
  	add_column :asked_questions, :question_id, :integer
  end
end
