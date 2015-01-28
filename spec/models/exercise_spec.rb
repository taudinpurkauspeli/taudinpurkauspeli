require 'rails_helper'

describe Exercise do
  it "has the name set correctly" do
    exercise = Exercise.new name:"Lihanautakuolemat"

    expect(exercise.name).to eq("Lihanautakuolemat")

  end

   it "has the anamnesis set correctly" do
    exercise = Exercise.new name:"Ripuloiva koira", anamnesis:"Koira sairastaa :("

    expect(exercise.anamnesis).to eq("Koira sairastaa :(")

  end


  describe "with correct name and anamnesis" do

    let!(:exercise){FactoryGirl.create(:exercise)}

    it "is saved" do
      expect(exercise).to be_valid
      expect(Exercise.count).to eq(1)
    end
  end

end