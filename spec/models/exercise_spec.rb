require 'spec_helper'

describe Exercise do
  it "has the name set correctly" do
    exercise = Exercise.new name:"Lihanautakuolemat"

    expect(exercise.name).to eq("Lihanautakuolemat")

  end


  describe "with correct name" do

    let!(:exercise){FactoryGirl.create(:exercise)}

    it "is saved" do
      expect(exercise).to be_valid
      expect(Exercise.count).to eq(1)
    end


  end
end