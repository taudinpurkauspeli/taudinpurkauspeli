class AddMultichoiceBank < ActiveRecord::Migration
  def change
    Bank.create name:"Monivalintakysymyspankki"
  end
end
