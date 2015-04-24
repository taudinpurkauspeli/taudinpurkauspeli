require 'rails_helper'

describe "Multichoice page for student", js:true do

  let!(:exercise){FactoryGirl.create(:exercise)}

  let!(:user){FactoryGirl.create(:student)}

  let!(:multichoice_task){FactoryGirl.create(:task, name: "Valitse kenelle soitat", exercise_id:exercise.id)}
  let!(:multichoice_subtask){FactoryGirl.create(:subtask, task_id:multichoice_task.id)}
  let!(:multichoice){FactoryGirl.create(:multichoice, subtask_id:multichoice_subtask.id)}
  let!(:option){FactoryGirl.create(:option, multichoice_id:multichoice.id)}
  let!(:option2){FactoryGirl.create(:option, multichoice_id:multichoice.id, content: "Ei tykkää", is_correct_answer: "wrong", explanation: "Ei oikea vastaus")}
  let!(:option3){FactoryGirl.create(:option, multichoice_id:multichoice.id, content: "Paljon tykkää", explanation: "Toinen oikea vastaus")}
  let!(:option4){FactoryGirl.create(:option, multichoice_id:multichoice.id, content: "Ehkä tykkää soittaa", is_correct_answer: "allowed", explanation: "Melkein oikea vastaus")}
  let!(:additional_dummy_task_to_prevent_ex_completion){FactoryGirl.create(:task, name:"Dummy task", exercise:exercise)}

  describe "student" do

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      click_and_wait('Lihanautakuolemat')
      click_and_wait('Toimenpiteet')
      click_and_wait(multichoice_task.name)
    end

    describe "should be able to complete multichoice task" do
      it "with right options selected" do
        check 'checked_options_1'
        check 'checked_options_3'
        expect {
          click_and_wait('Tarkista')
        }.to change(CompletedTask, :count).by(1)

        expect(page).to have_content 'Valitsit oikein!'
        expect(page).to have_content option.explanation
        expect(page).to have_content option2.explanation
        expect(page).to have_content option3.explanation
        expect(page).to have_content option4.explanation
      end

      it "with right and allowed options selected" do
        check 'checked_options_1'
        check 'checked_options_3'
        check 'checked_options_4'
        expect {
          click_and_wait('Tarkista')
        }.to change(CompletedTask, :count).by(1)

        expect(page).to have_content 'Valitsit oikein!'
        expect(page).to have_content option.explanation
        expect(page).to have_content option2.explanation
        expect(page).to have_content option3.explanation
        expect(page).to have_content option4.explanation
      end

    end

    describe "should not be able to complete multichoice task" do
      it "without any options selected" do
        expect {
          click_and_wait('Tarkista')
        }.not_to change(CompletedTask, :count)

        expect(page).to have_content 'Valinnoissa oli vielä virheitä!'
      end

      it "with wrong options selected" do

        check 'checked_options_1'
        check 'checked_options_2'
        check 'checked_options_3'

        expect {
          click_and_wait('Tarkista')
        }.not_to change(CompletedTask, :count)

        expect(page).to have_content 'Valinnoissa oli vielä virheitä!'
        expect(page).to have_content option.explanation
        expect(page).to have_content option2.explanation
        expect(page).to have_content option3.explanation
        expect(page).not_to have_content option4.explanation
      end

      it "when not all right options are selected" do
        check 'checked_options_1'
        check 'checked_options_4'

        expect {
          click_and_wait('Tarkista')
        }.not_to change(CompletedTask, :count)

        expect(page).to have_content 'Valinnoissa oli vielä virheitä!'
        expect(page).to have_content option.explanation
        expect(page).to have_content option4.explanation
        expect(page).not_to have_content option2.explanation
        expect(page).not_to have_content option3.explanation
      end
    end

    describe "after completing multichoice task" do

      before :each do
        check 'checked_options_1'
        check 'checked_options_3'
        click_and_wait('Tarkista')
        click_and_wait('Toimenpiteet')
        click_and_wait(multichoice_task.name)
      end

      it "should be able to view options and explanations of the multichoice" do
        expect(page).to have_content option.content
        expect(page).to have_content option2.content
        expect(page).to have_content option3.content
        expect(page).to have_content option4.content

        expect(page).to have_content option.explanation
        expect(page).to have_content option2.explanation
        expect(page).to have_content option3.explanation
        expect(page).to have_content option4.explanation
      end
    end
  end
end

