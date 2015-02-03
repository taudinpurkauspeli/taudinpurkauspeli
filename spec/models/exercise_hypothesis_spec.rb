require 'rails_helper'

RSpec.describe ExerciseHypothesis, :type => :model do
  it "has the ids set correctly" do
    exercise_hypothesis = ExerciseHypothesis.new exercise_id: 1, hypothesis_id: 1

    expect(exercise_hypothesis.exercise_id).to eq(1)
    expect(exercise_hypothesis.hypothesis_id).to eq(1)

  end

  describe "with correct ids" do

    let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis)}

    it "is saved" do
      expect(exercise_hypothesis).to be_valid
      expect(ExerciseHypothesis.count).to eq(1)
    end
  end
end
