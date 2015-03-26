class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
