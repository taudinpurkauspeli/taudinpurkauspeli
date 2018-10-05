require 'rails_helper'

RSpec.describe OwnFile, type: :model do
  it "has the name set correctly" do
    own_file = OwnFile.new name:"Minun tiedostoni"

    expect(own_file.name).to eq("Minun tiedostoni")

  end

end
