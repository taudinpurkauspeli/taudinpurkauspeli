class AddTitleIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :title_id, :integer
  end
end
