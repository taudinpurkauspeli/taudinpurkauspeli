require 'rails_helper'

describe "New Task page" do

  describe "if user is signed in as admin" do

    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
    end


    it "user should be able to create a new task without a task text-subtask" do
      visit new_task_path

      fill_in('name', with: "Soita asiakkaalle")

      click_button('Tallenna')

      expect(page).to have_content 'Toimenpiteen luominen onnistui!'
      expect(page).to have_content 'Soita asiakkaalle'
      expect(Task.count).to eq(1)
      expect(TaskText.count).to eq(0)
      expect(Subtask.count).to eq(0)
    end

    it "user should be able to create a new task with a task text-subtask" do
      visit new_task_path

      fill_in('name', with: "Soita asiakkaalle")
      fill_in('content', with: "Asiakas kertoo, että koira on kipeä.")

      click_button('Tallenna')

      expect(page).to have_content 'Toimenpiteen luominen onnistui!'
      expect(page).to have_content 'Soita asiakkaalle'
      expect(Task.count).to eq(1)
      expect(TaskText.count).to eq(1)
      expect(Subtask.count).to eq(1)

      expect(Task.first.task_texts.first.content).to eq("Asiakas kertoo, että koira on kipeä.")
    end

    it "user should not be able to create a new task without a name" do
      visit new_task_path

      fill_in('name', with: "")
      fill_in('content', with: "Asiakas kertoo, että koira on kipeä.")
      click_button('Tallenna')

      expect(current_path).to eq(tasks_path)
      expect(Task.count).to eq(0)
      expect(TaskText.count).to eq(0)
      expect(Subtask.count).to eq(0)


    end





  end

  describe "if user is signed in as normal user" do

    let!(:user){FactoryGirl.create(:user, admin: false)}


    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
    end


    it "user should not be able to visit new task page" do
      visit new_task_path

      expect(current_path).to eq(signin_path)

    end


  end




end
