require 'rails_helper'

describe Exercise do
  it "has the name set correctly" do
    exercise = Exercise.new name:"Lihanautakuolemat"

    expect(exercise.name).to eq("Lihanautakuolemat")

  end


  it "is not saved without a name" do
    exercise = Exercise.create name:"", anamnesis:"Koira sairastaa :("

    expect(exercise).not_to be_valid
    expect(Exercise.count).to eq(0)

  end

  it "is not saved with a too short name" do
    exercise = Exercise.create name:"h", anamnesis:"Koira sairastaa :("

    expect(exercise).not_to be_valid
    expect(Exercise.count).to eq(0)

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

=begin
    it "is not saved if the name is already in use" do
      exercise2 = Exercise.create name:"Lihanautakuolemat", anamnesis:"Voi voi koiraa"

      expect(exercise2).not_to be_valid
      expect(Exercise.count).to eq(1) 
    end
=end

    it "can be duplicated" do
      expect{
        exercise.create_duplicate(exercise)
      }.to change(Exercise, :count).by(1)

      new_exercise = Exercise.find(2)
      expect(new_exercise.name).to eq(exercise.name)
      expect(new_exercise.anamnesis).to eq(exercise.anamnesis)
    end

    describe "after duplication" do
      before :each do
        exercise.create_duplicate(exercise)
      end

      it "new exercise has only one anamnesis task" do
        new_exercise = Exercise.find(2)
        expect(new_exercise.tasks.where(level:0).count).to eq(1)
        expect(new_exercise.tasks.where(name: "Anamneesi").count).to eq(1)
      end
    end
  end

end