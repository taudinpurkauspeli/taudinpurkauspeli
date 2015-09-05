require 'rails_helper'

describe "Conclusion page for student", js:true do

  let!(:exercise){FactoryGirl.create(:exercise)}

  let!(:user){FactoryGirl.create(:student)}

  let!(:task){FactoryGirl.create(:task, exercise:exercise, level:1)}

  let!(:hypothesis_group){FactoryGirl.create(:hypothesis_group)}
  let!(:hypothesis_group2){FactoryGirl.create(:hypothesis_group, name: "Virustaudit")}

  let!(:hypothesis){FactoryGirl.create(:hypothesis, name: "Bakteeritauti", hypothesis_group:hypothesis_group)}
  let!(:hypothesis2){FactoryGirl.create(:hypothesis, name: "Kurkkukipu", hypothesis_group:hypothesis_group2)}
  let!(:hypothesis3){FactoryGirl.create(:hypothesis, hypothesis_group:hypothesis_group2)}

  let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis, task:task)}
  let!(:exercise_hypothesis2){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis2, task:task)}
  let!(:exercise_hypothesis3){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis3, task:task)}

  let!(:conclusion_task){FactoryGirl.create(:task, name: "Diagnoosi", exercise_id:exercise.id)}
  let!(:conclusion_subtask){FactoryGirl.create(:subtask, task_id:conclusion_task.id)}
  let!(:conclusion){FactoryGirl.create(:conclusion, title: "Diagnoosi", exercise_hypothesis_id:exercise_hypothesis.id, subtask_id:conclusion_subtask.id)}

  let!(:additional_dummy_task_to_prevent_ex_completion){FactoryGirl.create(:task, name:"Dummy task", exercise:exercise)}

=begin
  describe "student" do

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      click_and_wait('Lihanautakuolemat')
      click_and_wait('Toimenpiteet')
      click_and_wait(conclusion_task.name)
    end

    describe "should be able to complete conclusion task" do
      it "with required questions asked" do
        click_and_wait('ask_question_1')
        expect(page).to have_content question.content
        click_and_wait('ask_question_3')
        expect(page).to have_content question3.content
        expect {
          click_and_wait('Jatka')
        }.to change(CompletedTask, :count).by(1)

        expect(page).to have_content 'Toimenpide suoritettu!'
      end

      it "with right and allowed questions asked" do
        click_and_wait('ask_question_1')
        click_and_wait('ask_question_3')
        click_and_wait('ask_question_4')
        expect(page).to have_content question4.content
        expect {
          click_and_wait('Jatka')
        }.to change(CompletedTask, :count).by(1)

        expect(page).to have_content 'Toimenpide suoritettu!'
      end

      it "with right and wrong questions asked" do
        click_and_wait('ask_question_1')
        click_and_wait('ask_question_3')
        click_and_wait('ask_question_2')
        expect(page).to have_content question2.content
        expect {
          click_and_wait('Jatka')
        }.to change(CompletedTask, :count).by(1)

        expect(page).to have_content 'Toimenpide suoritettu!'
      end

    end

    describe "should not be able to complete conclusion task" do
      it "without any questions asked" do
        expect {
          click_and_wait('Jatka')
        }.not_to change(CompletedTask, :count)

        expect(page).to have_content 'Et ole vielä valinnut kaikkia tarpeellisia vaihtoehtoja!'
      end

      it "when not all right questions are asked" do
        click_and_wait('ask_question_1')
        click_and_wait('ask_question_4')

        expect {
          click_and_wait('Jatka')
        }.not_to change(CompletedTask, :count)

        expect(page).to have_content 'Et ole vielä valinnut kaikkia tarpeellisia vaihtoehtoja!'
      end
    end

    describe "after completing conclusion task" do

      before :each do
        click_and_wait('ask_question_1')
        click_and_wait('ask_question_3')
        click_and_wait('Jatka')
        click_and_wait('Toimenpiteet')
        click_and_wait(conclusion_task.name)
      end

      it "should be able to view questions and contents of the conclusion" do
        expect(AskedQuestion.count).to eq(2)

        expect(page).to have_button question.title
        click_and_wait('asked_question_1')
        expect(page).to have_content question.content

        expect(page).to have_button question2.title
        click_and_wait('ask_question_2')
        expect(page).to have_content question2.content

        expect(page).to have_button question3.title
        click_and_wait('asked_question_3')
        expect(page).to have_content question3.content

        expect(page).to have_button question4.title
        click_and_wait('ask_question_4')
        expect(page).to have_content question4.content
      end

      it "should be able to ask more questions" do
        expect(AskedQuestion.count).to eq(2)

        click_and_wait('ask_question_2')
        expect(page).to have_content question2.content

        click_and_wait('ask_question_4')
        expect(page).to have_content question4.content

        expect(AskedQuestion.count).to eq(4)
      end
    end
  end
=end
end

