class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :realname
      t.string :password_digest
      t.string :student_number
      t.integer :starting_year

      t.boolean :admin, default: false

      t.timestamps null: false
    end
  end
end