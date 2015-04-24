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

  describe "has_conclusion?" do
    let!(:has_conclusion){FactoryGirl.create(:exercise)}
    let!(:has_no_conclusion){FactoryGirl.create(:exercise)}
    let!(:task){FactoryGirl.create(:task, exercise:has_conclusion)}
    let!(:subt){FactoryGirl.create(:subtask, task:task)}
    let!(:conclusion){FactoryGirl.create(:conclusion, subtask:subt)}

    it "returns true if exercise has conclusion" do
      expect(has_conclusion.has_conclusion?).to eq(true)
    end

    it "returns false if exercise doesn't have conclusion" do
      expect(has_no_conclusion.has_conclusion?).to eq(false)
    end
  end
end