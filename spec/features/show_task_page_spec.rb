require 'rails_helper'

describe "Task show page", js:true do

  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:task){FactoryGirl.create(:task)}
  let!(:subtask){FactoryGirl.create(:subtask)}
  let!(:task_text){FactoryGirl.create(:task_text)}



  describe "if user is signed in as student" do

    let!(:user){FactoryGirl.create(:student)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      visit root_path

      click_button('Lihanautakuolemat')
      click_link('Toimenpiteet')
      click_button('Soita asiakkaalle')
    end

    it "user should be able to view the content of the text task" do
      expect(page).to have_content 'Lääkäri kertoo mikä on totuus'
    end

  end
end
