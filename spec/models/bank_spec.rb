require 'rails_helper'

RSpec.describe Bank, type: :model do
  it "has the name set correctly" do
    bank = Bank.new name:"Toimenpidepankki"

    expect(bank.name).to eq("Toimenpidepankki")

  end


  it "is not saved without a name" do
    bank = Bank.create name:""

    expect(bank).not_to be_valid
    expect(Bank.count).to eq(0)

  end

  it "is not saved with a too short name" do
    bank = Bank.create name:"a"

    expect(bank).not_to be_valid
    expect(Bank.count).to eq(0)

  end
end
