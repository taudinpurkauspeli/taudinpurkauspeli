require 'rails_helper'

RSpec.describe Multichoice, type: :model do
  it "is not saved without a question" do
    multichoice = Multichoice.create question:""

    expect(multichoice).not_to be_valid
    expect(Multichoice.count).to eq(0)
  end

  describe "with correct question" do

    let!(:multichoice){FactoryGirl.create(:multichoice)}

    it "is saved" do
      expect(multichoice).to be_valid
      expect(Multichoice.count).to eq(1)
    end
  end

  describe "with options" do

    let!(:exercise){FactoryGirl.create(:exercise)}

    let!(:user){FactoryGirl.create(:student)}

    let!(:multichoice_task){FactoryGirl.create(:task, name: "Valitse kenelle soitat", exercise_id:exercise.id)}
    let!(:multichoice_subtask){FactoryGirl.create(:subtask, task_id:multichoice_task.id)}
    let!(:multichoice){FactoryGirl.create(:multichoice, subtask_id:multichoice_subtask.id)}
    let!(:option){FactoryGirl.create(:option, multichoice_id:multichoice.id)}
    let!(:option2){FactoryGirl.create(:option, multichoice_id:multichoice.id, content: "Ei tykkää", is_correct_answer: "wrong", explanation: "Ei oikea vastaus")}
    let!(:option3){FactoryGirl.create(:option, multichoice_id:multichoice.id, content: "Paljon tykkää", explanation: "Toinen oikea vastaus")}
    let!(:option4){FactoryGirl.create(:option, multichoice_id:multichoice.id, content: "Ehkä tykkää soittaa", is_correct_answer: "allowed", explanation: "Melkein oikea vastaus")}

    describe "contains all right answers" do

      describe "returns true if" do
        it "only required answers selected" do
          answers = ["1", "3"]

          expect(multichoice.send(:contains_all_right_answers, answers)).to eq(true)
        end

        it "all required and some allowed answers selected" do
          answers = ["1", "3", "4"]

          expect(multichoice.send(:contains_all_right_answers, answers)).to eq(true)
        end
      end

      describe "returns false if" do
        it "not all required answers selected" do
          answers = ["1", "4"]

          expect(multichoice.send(:contains_all_right_answers, answers)).to eq(false)
        end
      end

    end

    describe "contains wrong answers" do

      describe "returns true if" do
        it "some wrong answers selected" do
          answers = ["1", "2", "3"]

          expect(multichoice.send(:contains_wrong_answers, answers)).to eq(true)
        end

      end

      describe "returns false if" do
        it "no wrong answers selected" do
          answers = ["1", "4"]

          expect(multichoice.send(:contains_all_right_answers, answers)).to eq(false)
        end
      end

    end

    describe "user answered correctly" do

      describe "returns true if" do
        it "all required answers selected" do
          answers = ["1", "3"]

          expect(multichoice.user_answered_correctly?(user, answers)).to eq(true)
        end

        it "all required and some allowed answers selected" do
          answers = ["1", "3", "4"]

          expect(multichoice.user_answered_correctly?(user, answers)).to eq(true)
        end
      end

      describe "returns false if" do
        it "wrong answers selected" do
          answers = ["1", "2", "3"]

          expect(multichoice.user_answered_correctly?(user, answers)).to eq(false)
        end
      end

      it "completes subtask if all required answers selected" do
        answers = ["1", "3"]
        expect {
          multichoice.user_answered_correctly?(user, answers)
        }.to change(CompletedSubtask, :count).by(1)

      end

    end
  end

end
