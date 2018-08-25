class AddTitleIdToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :title_id, :integer
    rename_column :questions, :title, :title_string
  end
end
