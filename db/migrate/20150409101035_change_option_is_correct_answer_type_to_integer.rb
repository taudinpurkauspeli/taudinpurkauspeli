class ChangeOptionIsCorrectAnswerTypeToInteger < ActiveRecord::Migration
  def self.up
    rename_column :options, :is_correct_answer, :is_correct_answer_boolean
    add_column :options, :is_correct_answer, :integer

    Option.reset_column_information
    Option.all.each { |c| c.update_attribute(:is_correct_answer, c.is_correct_answer_boolean) }
    remove_column :options, :is_correct_answer_boolean
  end

  def self.down
    rename_column :options, :is_correct_answer, :is_correct_answer_integer
    add_column :options, :is_correct_answer, :boolean

    Option.reset_column_information
    Option.all.each { |c| c.update_attribute(:is_correct_answer, c.is_correct_answer_integer) }
    remove_column :options, :is_correct_answer_integer
  end


end
