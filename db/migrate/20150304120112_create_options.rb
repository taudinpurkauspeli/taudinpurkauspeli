class CreateOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :options do |t|
      t.integer :multichoice_id
      t.string :content
      t.string :explanation
      t.boolean :is_correct_answer

      t.timestamps null: false
    end
  end
end
