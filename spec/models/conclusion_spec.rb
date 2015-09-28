require 'rails_helper'

RSpec.describe Conclusion, type: :model do
  let!(:correct_answer){FactoryGirl.create(:exercise_hypothesis, exercise_id:1, hypothesis_id:1, task_id:1)}
  let!(:wrong_answer){FactoryGirl.create(:exercise_hypothesis, exercise_id:1, hypothesis_id:2, task_id:1)}
  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:task){FactoryGirl.create(:task, exercise:exercise, level:1)}
  let!(:subtask){FactoryGirl.create(:subtask, task:task)}
  let!(:conclusion){FactoryGirl.create(:conclusion, subtask:subtask, exercise_hypothesis:correct_answer)}
  let!(:user){FactoryGirl.create(:user)}

  it "has to_s overridden" do
    expect(conclusion.to_s).to eq("Diagnoositoimenpide")
  end

  describe "user_answered_correctly?" do
    describe "when user answers wrong" do
      it "returns false" do
        expect(conclusion.user_answered_correctly?(user, wrong_answer.id)).to eq(false)
      end

      it "doesn't add completed_subtask to user" do
        expect {
          conclusion.user_answered_correctly?(user, wrong_answer.id)
        }.to change{user.subtasks.count}.by(0)
      end
    end

    describe "when user answers correct" do
      it "returns true" do
        expect(conclusion.user_answered_correctly?(user, correct_answer.id)).to eq(true)
      end

      it "adds completed_subtask to user" do
        expect {
          conclusion.user_answered_correctly?(user, correct_answer.id)
        }.to change{user.subtasks.count}.by(1)
      end
    end
  end
end
