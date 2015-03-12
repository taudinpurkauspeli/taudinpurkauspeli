class CreateMultichoices < ActiveRecord::Migration
  def change
    create_table :multichoices do |t|
      t.string :question
      t.integer :subtask_id

      t.timestamps null: false
    end
  end
end
