class AddAgreementsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :accept_academic_research, :boolean, default: false
    add_column :users, :accept_licence_agreement, :boolean, default: false
  end
end
