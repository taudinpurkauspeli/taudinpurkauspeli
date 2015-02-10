require 'rails_helper'

RSpec.describe HypothesisGroup, :type => :model do

  it "has the name set correctly" do
    hypothesis_group = HypothesisGroup.new name:"Bakteeritaudit"

    expect(hypothesis_group.name).to eq("Bakteeritaudit")

  end

  it "is not saved without a name" do
    hypothesis_group = HypothesisGroup.new name:"Bakteeritaudit"

    expect(hypothesis_group).to be_valid
    expect(HypothesisGroup.count).to eq(0)

  end

  describe "with correct name" do

    let!(:hypothesis_group){FactoryGirl.create(:hypothesis_group)}

    it "is saved" do
      expect(hypothesis_group).to be_valid
      expect(HypothesisGroup.count).to eq(1)
    end

    it "cannot create another with same name" do
      hypothesis_group2 = HypothesisGroup.create name: "Bakteeritaudit"
      expect(hypothesis_group2).not_to be_valid
      expect(HypothesisGroup.count).to eq(1)
    end
  end

end
