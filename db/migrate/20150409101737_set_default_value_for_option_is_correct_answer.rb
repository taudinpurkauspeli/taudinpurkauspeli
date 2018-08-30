class SetDefaultValueForOptionIsCorrectAnswer < ActiveRecord::Migration[5.1]
  def change
    change_column_default :options, :is_correct_answer, 0
  end
end
