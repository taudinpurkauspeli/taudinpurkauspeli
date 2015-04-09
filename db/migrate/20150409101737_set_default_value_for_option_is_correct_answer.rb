class SetDefaultValueForOptionIsCorrectAnswer < ActiveRecord::Migration
  def change
    change_column_default :options, :is_correct_answer, 0
  end
end
