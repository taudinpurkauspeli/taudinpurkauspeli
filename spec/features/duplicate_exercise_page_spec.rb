require 'rails_helper'

describe "Duplicate exercise page" do

  let!(:teacher){FactoryGirl.create(:user)}
  let!(:student){FactoryGirl.create(:student)}

  let!(:exercise){FactoryGirl.create(:exercise)}

  let!(:question_group){FactoryGirl.create(:question_group)}
  let!(:hypothesis_group){FactoryGirl.create(:hypothesis_group)}

  let!(:hypothesis){FactoryGirl.create(:hypothesis, hypothesis_group_id: hypothesis_group.id)}
  let!(:hypothesis2){FactoryGirl.create(:hypothesis, name: "Sorkkatauti", hypothesis_group_id: hypothesis_group.id)}

  #Task text task
  let!(:task_text_task){FactoryGirl.create(:task, name: "Tekstitehtävä", exercise_id:exercise.id)}
  let!(:task_text_subtask){FactoryGirl.create(:subtask, task_id:task_text_task.id)}
  let!(:task_text){FactoryGirl.create(:task_text, subtask_id:task_text_subtask.id)}

  #Multichoice task
  let!(:multichoice_task){FactoryGirl.create(:task, name: "Valitse kenelle soitat", exercise_id:exercise.id)}
  let!(:multichoice_subtask){FactoryGirl.create(:subtask, task_id:multichoice_task.id)}
  let!(:multichoice){FactoryGirl.create(:multichoice, subtask_id:multichoice_subtask.id)}
  let!(:option){FactoryGirl.create(:option, multichoice_id:multichoice.id)}
  let!(:option2){FactoryGirl.create(:option, multichoice_id:multichoice.id, content: "Ei tykkää", is_correct_answer: false, explanation: "Ei oikea vastaus")}
  let!(:option3){FactoryGirl.create(:option, multichoice_id:multichoice.id, content: "Ehkä tykkää", explanation: "Melkein oikea vastaus")}

  #Interview task
  let!(:interview_task){FactoryGirl.create(:task, name: "Haastattele asiakasta", exercise_id:exercise.id)}
  let!(:interview_subtask){FactoryGirl.create(:subtask, task_id:interview_task.id)}
  let!(:interview){FactoryGirl.create(:interview, subtask_id:interview_subtask.id)}
  let!(:question){FactoryGirl.create(:question, interview_id:interview.id)}
  let!(:question2){FactoryGirl.create(:question, interview_id:interview.id, title: "Onko ilma kylmä?", required: false, content: "Ilma ei ole kylmä.")}
  let!(:question3){FactoryGirl.create(:question, interview_id:interview.id, title: "Onko muita eläimiä?", content: "Muita eläimiä ei ole", question_group_id: question_group.id)}

  #Exercise hypotheses
  let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, exercise_id:exercise.id, hypothesis_id:hypothesis.id, task_id:1)}
  let!(:exercise_hypothesis2){FactoryGirl.create(:exercise_hypothesis, exercise_id:exercise.id, hypothesis_id:hypothesis2.id, task_id:task_text_task.id, explanation: "Tauti on tauti")}


  describe "teacher" do

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
    end


    it "should be able to duplicate an exercise" do
      expect {
        first(:button, "Kopioi").click
      }.to change(Exercise, :count).by(1)

      expect(current_path).to eq(exercises_path)

      expect(page).to have_content "Casen kopioiminen onnistui!"
      expect(Exercise.where(name:"Lihanautakuolemat").count).to eq(2)
    end

  end

  describe "duplicated exercise" do

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
      first(:button, "Kopioi").click
      @new_exercise = Exercise.find(2)
    end

    describe "should not duplicate" do
      it "question groups" do
        expect(QuestionGroup.count).to eq(1)
      end

      it "hypothesis groups" do
        expect(HypothesisGroup.count).to eq(1)
      end

      it "hypotheses" do
        expect(Hypothesis.count).to eq(2)
      end

      it "hypotheses" do
        expect(User.count).to eq(2)
      end

    end

    describe "should have correct" do

      it "number of anamnesis tasks" do
        expect(@new_exercise.tasks.where(level:0).count).to eq(1)
        expect(@new_exercise.tasks.where(name: "Anamneesi").count).to eq(1)
      end

      it "tasks" do
        expect(@new_exercise.tasks.where(name: "Tekstitehtävä").count).to eq(1)
        expect(@new_exercise.tasks.where(name: "Valitse kenelle soitat").count).to eq(1)
        expect(@new_exercise.tasks.where(name: "Haastattele asiakasta").count).to eq(1)
        expect(Task.count).to eq(8)
      end

      describe "task text task" do

        before :each do
          @new_task_text_task = @new_exercise.tasks.where(name: "Tekstitehtävä").first
        end

        it "with right content" do
          expect(@new_task_text_task.task_texts.first.content).to eq(task_text.content)
          expect(TaskText.count).to eq(2)
        end

      end

      describe "multichoice task" do

        before :each do
          @new_multichoice_task = @new_exercise.tasks.where(name: "Valitse kenelle soitat").first
        end

        it "with right question" do
          expect(@new_multichoice_task.multichoices.first.question).to eq(multichoice.question)
          expect(Multichoice.count).to eq(2)
        end

        it "with right options" do
          index = 0
          @new_multichoice_task.multichoices.first.options.each do |new_option|
            compare_option = multichoice_task.multichoices.first.options[index]
            expect(new_option.content).to eq(compare_option.content)
            expect(new_option.explanation).to eq(compare_option.explanation)
            expect(new_option.is_correct_answer).to eq(compare_option.is_correct_answer)
            index += 1
          end
          expect(Option.count).to eq(6)
        end

      end

      describe "interview task" do

        before :each do
          @new_interview_task = @new_exercise.tasks.where(name: "Haastattele asiakasta").first
        end

        it "with right title" do
          expect(@new_interview_task.interviews.first.title).to eq(interview.title)
          expect(Interview.count).to eq(2)
        end

        it "with right questions and question groups" do
          index = 0
          @new_interview_task.interviews.first.questions.each do |new_question|
            compare_question = interview_task.interviews.first.questions[index]

            expect(new_question.title).to eq(compare_question.title)
            expect(new_question.content).to eq(compare_question.content)
            expect(new_question.required).to eq(compare_question.required)
            expect(new_question.question_group_id).to eq(compare_question.question_group_id)
            index += 1
          end
          expect(Question.count).to eq(6)
        end

      end

      describe "exercise hypotheses" do

        it "with right explanations and prerequisite tasks" do

          index = 0
          @new_exercise.exercise_hypotheses.each do |new_exercise_hypothesis|
            compare_exercise_hypothesis = exercise.exercise_hypotheses[index]
            compare_task_id = @new_exercise.tasks.where(name: compare_exercise_hypothesis.task.name).first.id

            expect(new_exercise_hypothesis.explanation).to eq(compare_exercise_hypothesis.explanation)
            expect(new_exercise_hypothesis.task_id).to eq(compare_task_id)

            index += 1
          end
          expect(ExerciseHypothesis.count).to eq(4)
        end

      end

    end

  end

  describe "student" do

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")
    end

    it "should not be able to duplicate exercise" do
      expect(page).not_to have_button "Kopioi"
    end

  end
end
