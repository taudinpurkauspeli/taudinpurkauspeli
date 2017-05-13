class AddDefaultBanks < ActiveRecord::Migration
  def change

    Bank.create name:"Yleispankki"
    Bank.create name:"Haastattelukysymyspankki"
    Bank.create name:"Toimenpidepankki"
    Bank.create name:"Labratestipankki"

  end
end
