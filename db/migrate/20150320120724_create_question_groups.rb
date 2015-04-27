class CreateQuestionGroups < ActiveRecord::Migration
  def change
    create_table :question_groups do |t|
      t.string :title
      t.integer :interview_id
      t.timestamps null: false
    end
  end
end
