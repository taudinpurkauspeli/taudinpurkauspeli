require 'rails_helper'

describe "New Task page" do

  describe "if user is signed in as admin" do

    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
    end






    it "user should be able to create a new task without a task text-subtask" do
      visit new_task_path

      fill_in('task_name', with: "Soita asiakkaalle")

      click_button('Tallenna')

      expect(page).to have_content 'Toimenpide luotiin onnistuneesti.'
      #expect(page).to have_button 'Soita asiakkaalle'
      expect(Task.count).to eq(1)
      expect(TaskText.count).to eq(0)
      expect(Subtask.count).to eq(0)
    end

    it "user should be able to create a new task with a task text-subtask" do
      visit new_task_path

      fill_in('task_name', with: "Soita asiakkaalle")
      

      click_button('Tallenna')
      click_button('Luo uusi tekstimuotoinen alitoimenpide')

      fill_in('task_text_content', with: "Asiakas kertoo, että koira on kipeä.")
       click_button('Tallenna')
      #expect(page).to have_content 'Toimenpiteen luominen onnistui!'
      expect(page).to have_content 'Asiakas kertoo, että koira on kipeä.'
      expect(Task.count).to eq(1)
      expect(TaskText.count).to eq(1)
      expect(Subtask.count).to eq(1)

      expect(Task.first.task_texts.first.content).to eq("Asiakas kertoo, että koira on kipeä.")
    end

    it "user should not be able to create a new task without a name" do
      visit new_task_path

      fill_in('task_name', with: "")
      #fill_in('content', with: "Asiakas kertoo, että koira on kipeä.")
      click_button('Tallenna')

      expect(current_path).to eq(tasks_path)
      expect(Task.count).to eq(0)
      expect(TaskText.count).to eq(0)
      expect(Subtask.count).to eq(0)


    end



    # before :each do
    #   visit new_task_path
    #   fill_in('task_name', with: "Soita asiakkaalle")
    #   click_button('Tallenna')
    #   click_button('Luo uusi tekstimuotoinen alitoimenpide')

    #   fill_in('task_text_content', with: "Asiakas kertoo, että koira on kipeä.")
    #    click_button('Tallenna')
    # end

    it "user should be able to update the content of a task text subtask" do
      #EIHHGG!
       visit new_task_path
      fill_in('task_name', with: "Soita asiakkaalle")
      click_button('Tallenna')
      click_button('Luo uusi tekstimuotoinen alitoimenpide')

      fill_in('task_text_content', with: "Asiakas kertoo, että koira on kipeä.")
       click_button('Tallenna')


      click_link('Muokkaa')
      click_button('Tekstimuotoinen alitoimenpide')
      fill_in('task_text_content', with: "Asiakas kertoo, että koira ei ole kipeä!")
      click_button('Tallenna')

      expect(current_path).to eq(edit_task_path(1))
      expect(Task.count).to eq(1)
      expect(TaskText.count).to eq(1)
      expect(Subtask.count).to eq(1)

      expect(Task.first.task_texts.first.content).to eq("Asiakas kertoo, että koira ei ole kipeä!")

      
    end

 it "user should not be able to create a new task text subtask without content" do
      visit new_task_path

      fill_in('task_name', with: "Uusi tehtävä")
      #fill_in('content', with: "Asiakas kertoo, että koira on kipeä.")
      click_button('Tallenna')

          click_button('Luo uusi tekstimuotoinen alitoimenpide')

      fill_in('task_text_content', with: "")
       click_button('Tallenna')
      #expect(page).to have_content 'Toimenpiteen luominen onnistui!'
      expect(page).to have_content 'Seuraavat virheet estivät tallennuksen:'
      expect(Task.count).to eq(1)
      expect(TaskText.count).to eq(0)
      expect(Subtask.count).to eq(0)


    end
    it "user should not be able to save task edit with invalid name" do
       #EIHHGG!
       visit new_task_path
      fill_in('task_name', with: "Soita asiakkaalle")
      click_button('Tallenna')
      click_button('Luo uusi tekstimuotoinen alitoimenpide')

      fill_in('task_text_content', with: "Asiakas kertoo, että koira on kipeä.")
       click_button('Tallenna')
       click_link('Muokkaa')
       fill_in('task_name', with: "")
       click_button('Päivitä')

       expect(page).to have_content 'Seuraavat virheet estivät tallennuksen:'
       expect(Task.first.name).to eq("Soita asiakkaalle")





    end

    it "user should not be able to save task text edit with invalid content" do

 #EIHHGG!
       visit new_task_path
      fill_in('task_name', with: "Soita asiakkaalle")
      click_button('Tallenna')
      click_button('Luo uusi tekstimuotoinen alitoimenpide')

      fill_in('task_text_content', with: "Asiakas kertoo, että koira on kipeä.")
       click_button('Tallenna')


      click_link('Muokkaa')
      click_button('Tekstimuotoinen alitoimenpide')
      fill_in('task_text_content', with: "")
      click_button('Tallenna')

      expect(page).to have_content("Seuraavat virheet estivät tallennuksen:")
      expect(Task.first.task_texts.first.content).to eq("Asiakas kertoo, että koira on kipeä.")
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
