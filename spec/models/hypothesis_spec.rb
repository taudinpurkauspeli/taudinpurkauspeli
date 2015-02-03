require 'rails_helper'

RSpec.describe Hypothesis, :type => :model do

  it "has the name set correctly" do
    hypothesis = Hypothesis.new name:"Virustauti"

    expect(hypothesis.name).to eq("Virustauti")

  end

  describe "with correct name" do

    let!(:hypothesis){FactoryGirl.create(:hypothesis)}

    it "is saved" do
      expect(hypothesis).to be_valid
      expect(Hypothesis.count).to eq(1)
    end
  end

end
