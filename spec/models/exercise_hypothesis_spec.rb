require 'rails_helper'

RSpec.describe ExerciseHypothesis, :type => :model do
  it "has the ids set correctly" do
    exercise_hypothesis = ExerciseHypothesis.new exercise_id: 1, hypothesis_id: 1

    expect(exercise_hypothesis.exercise_id).to eq(1)
    expect(exercise_hypothesis.hypothesis_id).to eq(1)

  end

  describe "with correct ids" do

    let!(:exercise){FactoryGirl.create(:exercise)}
    let!(:hypothesis){FactoryGirl.create(:hypothesis)}

    let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis)}

    it "is saved" do
      expect(exercise_hypothesis).to be_valid
      expect(ExerciseHypothesis.count).to eq(1)
    end
  end

  describe "with explanation and hypothesis" do
    let!(:exercise){FactoryGirl.create(:exercise)}
    let!(:hypothesis){FactoryGirl.create(:hypothesis)}

    let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis)}

    it "returns the normal explanation" do
      expect(exercise_hypothesis.get_explanation).to eq('"Virustauti" poissuljettu. Perustelu: Anamneesin mukaan tauti on virustauti')
    end

    it "returns the right explanation" do
      expect(exercise_hypothesis.get_right_explanation).to eq('Onnittelut! Sait selville, että kyseessä oli Virustauti. Mitä sinun tulee vielä tehdä? Perustelu: Anamneesin mukaan tauti on virustauti')
    end

  end

  describe "has prerequisite set"  do
    let!(:exercise){FactoryGirl.create(:exercise)}
    let!(:hypothesis){FactoryGirl.create(:hypothesis)}
    let!(:task){FactoryGirl.create(:task, exercise:exercise, level:1)}

    it "and it is returned" do
      exercise_hypothesis = ExerciseHypothesis.new exercise: exercise, hypothesis: hypothesis
      exercise_hypothesis.task = task
      expect(exercise_hypothesis.get_prerequisite).to eq(task)
    end
  end
end
