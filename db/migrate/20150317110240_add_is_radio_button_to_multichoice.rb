class AddIsRadioButtonToMultichoice < ActiveRecord::Migration
  def change
    add_column :multichoices, :is_radio_button, :boolean
  end
end
