require 'rails_helper'

describe "Task show page" do

  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:task){FactoryGirl.create(:task)}
  let!(:subtask){FactoryGirl.create(:subtask)}
  let!(:task_text){FactoryGirl.create(:task_text)}

  let!(:multichoice_task){FactoryGirl.create(:task, name: "Valitse kenelle soitat", level: 1)}
  let!(:multichoice_subtask){FactoryGirl.create(:subtask, task_id:2)}
  let!(:multichoice){FactoryGirl.create(:multichoice, subtask_id: 2)}
  let!(:option){FactoryGirl.create(:option)}
  let!(:option2){FactoryGirl.create(:option, content: "Ei tykkää", value: false, explanation: "Ei oikea vastaus")}
  let!(:option3){FactoryGirl.create(:option, content: "Ehkä tykkää", explanation: "Melkein oikea vastaus")}


  describe "if user is signed in as student" do

    let!(:user){FactoryGirl.create(:student)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      visit root_path

      click_button('Lihanautakuolemat')
      click_link('Toimenpiteet')

    end

    it "user should be able to view the content of the text task" do
      click_button('Soita asiakkaalle')
      expect(page).to have_content 'Lääkäri kertoo mikä on totuus'
    end

    it "user should be able to view the question and answer options for multichoice task" do
      click_button(multichoice_task.name)

      expect(page).to have_content multichoice.question
      expect(page).to have_content option.content
      expect(page).to have_content option2.content
      expect(page).to have_content option3.content
    end

  end
end
