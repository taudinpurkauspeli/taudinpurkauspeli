require 'rails_helper'

RSpec.describe Hypothesis, :type => :model do

  it "has the name set correctly" do
    hypothesis = Hypothesis.new name:"Virustauti"

    expect(hypothesis.name).to eq("Virustauti")

  end

  it "is not saved without a name" do
    hypothesis = Hypothesis.create name:""

    expect(hypothesis).not_to be_valid
    expect(Hypothesis.count).to eq(0)

  end

  describe "with correct name" do

    let!(:hypothesis){FactoryGirl.create(:hypothesis)}

    it "is saved" do
      expect(hypothesis).to be_valid
      expect(Hypothesis.count).to eq(1)
    end

    it "cannot create another with same name" do
      hypothesis2 = Hypothesis.create name: "Virustauti"
      expect(hypothesis2).not_to be_valid
      expect(Hypothesis.count).to eq(1)
    end
  end

end
