require 'rails_helper'

describe "Interview page for student", js:true do

  let!(:exercise){FactoryGirl.create(:exercise)}

  let!(:user){FactoryGirl.create(:student)}

  let!(:interview_task){FactoryGirl.create(:task, name: "Asiakkaan haastattelu", exercise_id:exercise.id)}
  let!(:interview_subtask){FactoryGirl.create(:subtask, task_id:interview_task.id)}
  let!(:interview){FactoryGirl.create(:interview, subtask_id:interview_subtask.id)}
  let!(:question){FactoryGirl.create(:question, interview_id:interview.id)}
  let!(:question2){FactoryGirl.create(:question, interview_id:interview.id, content: "Lehmä söi ruohoa", required: "wrong", title: "Onko lehmä syönyt hyvin?")}
  let!(:question3){FactoryGirl.create(:question, interview_id:interview.id, content: "Karsina on siivottu", title: "Onko karsina puhdas?")}
  let!(:question4){FactoryGirl.create(:question, interview_id:interview.id, content: "Aurinko paistoi", required: "allowed", title: "Millainen oli sää?")}
  let!(:additional_dummy_task_to_prevent_ex_completion){FactoryGirl.create(:task, name:"Dummy task", exercise:exercise)}

  describe "student" do

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      wait_and_trigger_click('Lihanautakuolemat')
      wait_and_trigger_click('Toimenpiteet')
      wait_and_trigger_click(interview_task.name)
    end

    describe "should be able to complete interview task" do
      it "with required questions asked" do
        wait_and_trigger_click('ask_question_1')
        expect(page).to have_content question.content
        wait_and_trigger_click('ask_question_3')
        expect(page).to have_content question3.content
        expect {
          wait_and_trigger_click('Jatka')
        }.to change(CompletedTask, :count).by(1)

        expect(page).to have_content 'Toimenpide suoritettu!'
      end

      it "with right and allowed questions asked" do
        wait_and_trigger_click('ask_question_1')
        wait_and_trigger_click('ask_question_3')
        wait_and_trigger_click('ask_question_4')
        expect(page).to have_content question4.content
        expect {
          wait_and_trigger_click('Jatka')
        }.to change(CompletedTask, :count).by(1)

        expect(page).to have_content 'Toimenpide suoritettu!'
      end

      it "with right and wrong questions asked" do
        wait_and_trigger_click('ask_question_1')
        wait_and_trigger_click('ask_question_3')
        wait_and_trigger_click('ask_question_2')
        expect(page).to have_content question2.content
        expect {
          wait_and_trigger_click('Jatka')
        }.to change(CompletedTask, :count).by(1)

        expect(page).to have_content 'Toimenpide suoritettu!'
      end

    end

    describe "should not be able to complete interview task" do
      it "without any questions asked" do
        expect {
          wait_and_trigger_click('Jatka')
        }.not_to change(CompletedTask, :count)

        expect(page).to have_content 'Et ole vielä valinnut kaikkia tarpeellisia vaihtoehtoja!'
      end

      it "when not all right questions are asked" do
        wait_and_trigger_click('ask_question_1')
        wait_and_trigger_click('ask_question_4')

        expect {
          wait_and_trigger_click('Jatka')
        }.not_to change(CompletedTask, :count)

        expect(page).to have_content 'Et ole vielä valinnut kaikkia tarpeellisia vaihtoehtoja!'
      end
    end

    describe "after completing interview task" do

      before :each do
        wait_and_trigger_click('ask_question_1')
        wait_and_trigger_click('ask_question_3')
        wait_and_trigger_click('Jatka')
        wait_and_trigger_click('Toimenpiteet')
        wait_and_trigger_click(interview_task.name)
      end

      it "should be able to view questions and contents of the interview" do
        expect(AskedQuestion.count).to eq(2)

        expect(page).to have_button question.title
        wait_and_trigger_click('asked_question_1')
        expect(page).to have_content question.content

        expect(page).to have_button question2.title
        wait_and_trigger_click('ask_question_2')
        expect(page).to have_content question2.content

        expect(page).to have_button question3.title
        wait_and_trigger_click('asked_question_3')
        expect(page).to have_content question3.content

        expect(page).to have_button question4.title
        wait_and_trigger_click('ask_question_4')
        expect(page).to have_content question4.content
      end

      it "should be able to ask more questions" do
        expect(AskedQuestion.count).to eq(2)

        wait_and_trigger_click('ask_question_2')
        expect(page).to have_content question2.content

        wait_and_trigger_click('ask_question_4')
        expect(page).to have_content question4.content

        expect(AskedQuestion.count).to eq(4)
      end
    end
  end
end

