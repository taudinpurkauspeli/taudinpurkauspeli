require 'rails_helper'

describe "New Task page" do

  describe "if user is signed in as admin" do

    let!(:user){FactoryGirl.create(:user)}
    let!(:exercise){FactoryGirl.create(:exercise)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
      click_button(exercise.name)
    end



    it "user should be able to create a new task with a multichoice subtask" do
      visit new_task_path
      fill_in('task_name', with: "Kysymyksiä asiakkaalle")
      click_button('Tallenna')
      click_button('Luo uusi monivalinta-alitoimenpide')

      fill_in('multichoice_question', with: "Mitä kysyt asiakkaalta:")
      click_button('Tallenna kysymys')

      expect(page).to have_content 'Kysymys lisättiin onnistuneesti.'
      expect(Task.count).to eq(1)
      expect(Multichoice.count).to eq(1)
      expect(Subtask.count).to eq(1)
      expect(Multichoice.first.question).to eq("Mitä kysyt asiakkaalta:")
    end


    it "user should be able to update the content of a multichoice subtask" do
      visit new_task_path
      fill_in('task_name', with: "Kysymyksiä asiakkaalle")
      click_button('Tallenna')
      click_button('Luo uusi monivalinta-alitoimenpide')

      fill_in('multichoice_question', with: "Mitä kysyt asiakkaalta:")
      click_button('Tallenna kysymys')

      expect(page).to have_content 'Muokkaa monivalintakysymystä'
      fill_in('multichoice_question', with: "Useita kysymyksiä asiakkaalle:")
      click_button('Tallenna kysymys')

      expect(current_path).to eq(edit_multichoice_path(1))
      expect(Task.count).to eq(1)
      expect(Multichoice.count).to eq(1)
      expect(Subtask.count).to eq(1)
      expect(Multichoice.first.question).to eq("Useita kysymyksiä asiakkaalle:")

    end

    it "user should not be able to create a new multichoice subtask without question" do
      visit new_task_path
      fill_in('task_name', with: "Uusi tehtävä")
      click_button('Tallenna')
      click_button('Luo uusi monivalinta-alitoimenpide')

      fill_in('multichoice_question', with: "")
      click_button('Tallenna kysymys')

      expect(page).to have_content 'Seuraavat virheet estivät tallennuksen:'
      expect(Task.count).to eq(1)
      expect(Multichoice.count).to eq(0)
      expect(Subtask.count).to eq(0)
    end

    it "user should not be able to save multichoice edit with invalid name" do
      visit new_task_path
      fill_in('task_name', with: "Kysymyksiä asiakkaalle")
      click_button('Tallenna')
      click_button('Luo uusi monivalinta-alitoimenpide')

      fill_in('multichoice_question', with: "Mitä kysyt asiakkaalta:")
      click_button('Tallenna kysymys')
      fill_in('multichoice_question', with: "")
      click_button('Tallenna kysymys')

      expect(page).to have_content 'Seuraavat virheet estivät tallennuksen:'
      expect(Task.first.name).to eq("Kysymyksiä asiakkaalle")
    end

  end

end
