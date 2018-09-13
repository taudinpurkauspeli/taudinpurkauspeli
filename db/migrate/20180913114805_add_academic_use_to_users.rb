class AddAcademicUseToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :accept_academic_use, :boolean, default: false
  end
end
