require 'rails_helper'

RSpec.describe Title, type: :model do
  it "has the text set correctly" do
    title = Title.new text:"Kysy lehmistä"

    expect(title.text).to eq("Kysy lehmistä")

  end


  it "is not saved without a text" do
    title = Title.create text:""

    expect(title).not_to be_valid
    expect(Title.count).to eq(0)

  end

  it "is not saved with a too short text" do
    title = Title.create text:"a"

    expect(title).not_to be_valid
    expect(Title.count).to eq(0)

  end
end
