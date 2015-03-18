require 'rails_helper'

RSpec.describe Multichoice, type: :model do

  it "has the content set correctly" do
    multichoice = Multichoice.new question:"Soitatko asiakkaalle?"

    expect(multichoice.question).to eq("Soitatko asiakkaalle?")

  end

  describe "with correct content" do

    let!(:multichoice){FactoryGirl.create(:multichoice)}

    it "is saved" do
      expect(multichoice).to be_valid
      expect(Multichoice.count).to eq(1)
    end
  end

  describe "with incorrect content" do

    let!(:multichoice){Multichoice.create question:""}

    it "is not saved" do
      expect(multichoice).not_to be_valid
      expect(Multichoice.count).to eq(0)
    end
  end
end
