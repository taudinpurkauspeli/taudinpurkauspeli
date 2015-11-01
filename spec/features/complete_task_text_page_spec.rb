require 'rails_helper'

describe "Task text page for student", js:true do

  let!(:exercise){FactoryGirl.create(:exercise)}

  let!(:user){FactoryGirl.create(:student)}

  let!(:task_text_task){FactoryGirl.create(:task, name: "Tekstitehtävä", exercise_id:exercise.id)}
  let!(:task_text_subtask){FactoryGirl.create(:subtask, task_id:task_text_task.id)}
  let!(:task_text){FactoryGirl.create(:task_text, subtask_id:task_text_subtask.id)}
  let!(:additional_dummy_task_to_prevent_ex_completion){FactoryGirl.create(:task, name:"Dummy task", exercise:exercise)}

  describe "student" do

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      wait_and_trigger_click('Lihanautakuolemat')
      wait_and_trigger_click('Toimenpiteet')
      wait_and_trigger_click(task_text_task.name)
    end

    it "should be able to complete text task" do
      expect {
        wait_and_trigger_click('Jatka')
      }.to change(CompletedTask, :count).by(1)

      expect(page).to have_content 'Tehtävä suoritettu!'
      expect(page).to have_content 'Toimenpide suoritettu!'
    end

    describe "after completing text task" do

      before :each do
        wait_and_trigger_click('Jatka')
        wait_and_trigger_click('Toimenpiteet')
        wait_and_trigger_click(task_text_task.name)
      end

      it "should be able to view the text" do
        expect(page).to have_content task_text.content
      end

    end

  end
end