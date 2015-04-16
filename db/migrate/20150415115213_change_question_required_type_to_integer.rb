class ChangeQuestionRequiredTypeToInteger < ActiveRecord::Migration

  def self.up
    rename_column :questions, :required, :required_boolean
    add_column :questions, :required, :integer

    Question.reset_column_information
    Question.all.each { |q| q.update_attribute(:required, (q.required_boolean ? 1 : 0)) }
    remove_column :questions, :required_boolean
  end

  def self.down
    rename_column :questions, :required, :required_integer
    add_column :questions, :required, :boolean

    Question.reset_column_information
    Question.all.each { |q| q.update_attribute(:required, (q.required_integer == 1 ? true : false)) }
    remove_column :questions, :required_integer
  end

end
