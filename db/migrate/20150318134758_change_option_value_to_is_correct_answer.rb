class ChangeOptionValueToIsCorrectAnswer < ActiveRecord::Migration
  def change
    rename_column :options, :value, :is_correct_answer
  end
end
