class CreateMultichoices < ActiveRecord::Migration[5.1]
  def change
    create_table :multichoices do |t|
      t.string :question
      t.integer :subtask_id

      t.boolean :is_radio_button
      t.timestamps null: false
    end
  end
end
