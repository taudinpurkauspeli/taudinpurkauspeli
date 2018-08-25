class AddDefaultBanks < ActiveRecord::Migration[5.1]
  def change

    Bank.create name:"Yleispankki"
    Bank.create name:"Haastattelukysymyspankki"
    Bank.create name:"Toimenpidepankki"
    Bank.create name:"Labratestipankki"

  end
end
