class ChangeOptionIsCorrectAnswerTypeToInteger < ActiveRecord::Migration
  def change
    change_column :options, :is_correct_answer, :integer
  end
end
