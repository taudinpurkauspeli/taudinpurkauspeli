class AddMultichoiceBank < ActiveRecord::Migration[5.1]
  def change
    Bank.create name:"Monivalintakysymyspankki"
  end
end
