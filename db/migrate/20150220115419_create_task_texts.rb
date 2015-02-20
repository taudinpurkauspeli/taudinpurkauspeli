class CreateTaskTexts < ActiveRecord::Migration
  def change
    create_table :task_texts do |t|
      t.string :content

      t.timestamps null: false
    end
  end
end
