class CreateQuestionGroups < ActiveRecord::Migration
  def change
    create_table :question_groups do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
