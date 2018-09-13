class SetDefaultValueForQuestionRequired < ActiveRecord::Migration[5.1]
  def change
    change_column_default :questions, :required, 0
  end
end
