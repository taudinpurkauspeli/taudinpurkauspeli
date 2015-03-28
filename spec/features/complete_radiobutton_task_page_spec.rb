require 'rails_helper'

describe "Radiobutton page for student", js:true do

  let!(:exercise){FactoryGirl.create(:exercise)}

  let!(:user){FactoryGirl.create(:student)}

  let!(:radiobutton_task){FactoryGirl.create(:task, name: "Valitse kenelle soitat", exercise_id:exercise.id)}
  let!(:radiobutton_subtask){FactoryGirl.create(:subtask, task_id:radiobutton_task.id)}
  let!(:radiobutton){FactoryGirl.create(:radiobutton, subtask_id:radiobutton_subtask.id)}
  let!(:option){FactoryGirl.create(:option, multichoice_id:radiobutton.id, content: "Asiakkaan isälle", is_correct_answer: false, explanation: "Ei oikein!")}
  let!(:option2){FactoryGirl.create(:option, multichoice_id:radiobutton.id, content: "Asiakkaan äidille", is_correct_answer: false, explanation: "Ei oikea vastaus")}
  let!(:option3){FactoryGirl.create(:option, multichoice_id:radiobutton.id, content: "Asiakkaalles", explanation: "Oikea vastaus")}


  describe "student" do

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      visit root_path

      click_and_wait('Lihanautakuolemat')
      click_and_wait('Toimenpiteet')
      click_and_wait(radiobutton_task.name)

    end

    describe "should be able to complete radiobutton task" do

      it "with right option selected" do
        choose 'checked_options_3'

        expect {
          click_and_wait('Tarkista')
        }.to change(CompletedTask, :count).by(1)

        expect(page).to have_content 'Valitsit oikein!'
        expect(page).to have_content option.explanation
        expect(page).to have_content option2.explanation
        expect(page).to have_content option3.explanation
      end
    end

    describe "should not be able to complete radiobutton task" do

      it "without any option selected" do

        expect {
          click_and_wait('Tarkista')
        }.not_to change(CompletedTask, :count)

        expect(page).to have_content 'Valinnoissa oli vielä virheitä!'
      end

      it "with wrong option selected" do

        choose 'checked_options_1'

        expect {
          click_and_wait('Tarkista')
        }.not_to change(CompletedTask, :count)

        expect(page).to have_content 'Valinnoissa oli vielä virheitä!'
      end

    end

    describe "after completing radiobutton task" do

      before :each do
        choose 'checked_options_3'
        click_and_wait('Tarkista')
        click_and_wait('Toimenpiteet')
        click_and_wait(radiobutton_task.name)
      end

      it "should be able to view options and explanations of radiobutton" do
        expect(page).to have_content option.content
        expect(page).to have_content option2.content
        expect(page).to have_content option3.content

        expect(page).to have_content option.explanation
        expect(page).to have_content option2.explanation
        expect(page).to have_content option3.explanation
      end

    end
  end
end

