require 'rails_helper'

RSpec.describe Option, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  it "has the content set correctly" do
    option = Option.new content:"Soitan asiakkaalle"

    expect(option.content).to eq("Soitan asiakkaalle")

  end

  describe "with correct content" do

    let!(:option){FactoryGirl.create(:option)}

    it "is saved" do
      expect(option).to be_valid
      expect(Option.count).to eq(1)
    end
  end

  describe "with incorrect content" do

    let!(:option){Option.create content:""}

    it "is not saved" do
      expect(option).not_to be_valid
      expect(Option.count).to eq(0)
    end
  end
end
