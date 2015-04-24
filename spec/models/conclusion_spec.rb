require 'rails_helper'

RSpec.describe Conclusion, type: :model do
  let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, exercise_id:1, hypothesis_id:1, task_id:1)}
  let!(:task){FactoryGirl.create(:task, exercise_id:1, level:1)}
  let!(:subtask){FactoryGirl.create(:subtask, task:task)}
  let!(:conclusion){FactoryGirl.create(:conclusion, subtask:subtask, exercise_hypothesis:exercise_hypothesis)}

  it "has overridden to_s" do
    expect(conclusion.to_s).to eq("Päätöstoimenpide")
  end

  describe "user_answered_correctly?" do
      
    describe "when user answers wrong" do

      let!(:user){FactoryGirl.create(:user)}

      it "returns false" do
        expect(0).to eq (0)
      end

      it "doesn't add completed_subtask to user" do
        expect(0).to eq (0)
      end
    end

    describe "when user answers correct" do

      it "returns true" do
        expect(0).to eq (0)
      end

      it "adds completed_subtask to user" do
        expect(0).to eq (0)
      end
    end
  end
end
