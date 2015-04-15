class SetDefaultValueForQuestionRequired < ActiveRecord::Migration
  def change
    change_column_default :questions, :required, 0
  end
end
