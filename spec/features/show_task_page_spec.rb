require 'rails_helper'

describe "Task show page", js:true do

  let!(:exercise){FactoryGirl.create(:exercise)}

  #Task text
  let!(:task){FactoryGirl.create(:task, exercise:exercise, level:1)}
  let!(:subtask){FactoryGirl.create(:subtask, task:task)}
  let!(:task_text){FactoryGirl.create(:task_text, subtask:subtask)}

  #Multichoice
  let!(:multichoice_task){FactoryGirl.create(:task, name: "Valitse kenelle soitat", level: 1, exercise:exercise)}
  let!(:multichoice_subtask){FactoryGirl.create(:subtask, task:multichoice_task)}
  let!(:multichoice){FactoryGirl.create(:multichoice, subtask:multichoice_subtask)}
  let!(:option){FactoryGirl.create(:option, multichoice:multichoice)}
  let!(:option2){FactoryGirl.create(:option, multichoice:multichoice, content: "Ei tykkää", is_correct_answer: "wrong", explanation: "Ei oikea vastaus")}
  let!(:option3){FactoryGirl.create(:option, multichoice:multichoice, content: "Ehkä tykkää", explanation: "Melkein oikea vastaus")}

  #Radiobutton
  let!(:radiobutton_task){FactoryGirl.create(:task, name: "Mikä lääke oikea", level: 1, exercise:exercise)}
  let!(:radiobutton_subtask){FactoryGirl.create(:subtask, task:radiobutton_task)}
  let!(:radiobutton){FactoryGirl.create(:radiobutton, subtask:radiobutton_subtask)}
  let!(:option4){FactoryGirl.create(:option, multichoice:radiobutton, content: "Bakteeri")}
  let!(:option5){FactoryGirl.create(:option, multichoice:radiobutton, content: "Virus", is_correct_answer: "wrong", explanation: "Ei oikea vastaus")}
  let!(:option6){FactoryGirl.create(:option, multichoice:radiobutton, content: "Joku muu", is_correct_answer: "wrong", explanation: "Melkein oikea vastaus")}


  describe "student" do

    let!(:user){FactoryGirl.create(:student)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      visit root_path

      wait_and_trigger_click('Lihanautakuolemat')
      wait_and_trigger_click('Toimenpiteet')
    end

    describe "should be able to view the" do

      it "content of the text task" do
        wait_and_trigger_click('Soita asiakkaalle')
        expect(page).to have_content 'Lääkäri kertoo mikä on totuus'
      end

      describe "question and answer options for a" do

        it "multichoice task" do
          wait_and_trigger_click(multichoice_task.name)

          expect(page).to have_content multichoice.question
          expect(page).to have_content option.content
          expect(page).to have_content option2.content
          expect(page).to have_content option3.content
        end

        it "radiobutton task" do
          wait_and_trigger_click(radiobutton_task.name)

          expect(page).to have_content radiobutton.question
          expect(page).to have_content option4.content
          expect(page).to have_content option5.content
          expect(page).to have_content option6.content
        end
      end

    end
  end

  describe "teacher" do

    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")

      visit root_path

      wait_and_trigger_click('Lihanautakuolemat')
      wait_and_trigger_click('Toimenpiteet')
    end

    describe "should be able to preview the" do

      it "content of a text task" do
        wait_and_trigger_click(task.name)
        wait_and_trigger_click('Esikatsele')
        expect(page).to have_content task_text.content
        expect(page).to have_content 'Toimenpide: ' + task.name
        expect(page).not_to have_button 'Jatka'
      end

      describe "question, answer options and explanations for a" do
        it "multichoice task" do
          wait_and_trigger_click(multichoice_task.name)
          wait_and_trigger_click('Esikatsele')

          expect(page).to have_content multichoice.question
          expect(page).to have_content option.content
          expect(page).to have_content option2.content
          expect(page).to have_content option3.content

          expect(page).to have_content option.explanation
          expect(page).to have_content option2.explanation
          expect(page).to have_content option3.explanation

          expect(page).not_to have_button 'Tarkista'
        end

        it "radiobutton task" do
          wait_and_trigger_click(radiobutton_task.name)
          wait_and_trigger_click('Esikatsele')

          expect(page).to have_content radiobutton.question
          expect(page).to have_content option4.content
          expect(page).to have_content option5.content
          expect(page).to have_content option6.content

          expect(page).to have_content option4.explanation
          expect(page).to have_content option5.explanation
          expect(page).to have_content option6.explanation

          expect(page).not_to have_button 'Tarkista'
        end
      end
    end
  end
end
