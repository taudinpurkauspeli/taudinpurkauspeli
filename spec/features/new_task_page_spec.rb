require 'rails_helper'

describe "New Task page", js:true do
  let!(:exercise){FactoryGirl.create(:exercise)}

  describe "teacher" do
    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
      click_and_wait(exercise.name)
      click_and_wait('Toimenpiteet')
      click_and_wait('+ Luo uusi toimenpide')
    end

    it "should be able to create a new task without a subtask" do
      fill_in('task_name', with: "Soita asiakkaalle")
      expect {
        click_and_wait('Tallenna')
      }.to change(Task, :count).by(1)

      expect(page).to have_content 'Toimenpide luotiin onnistuneesti.'
      expect(number_of_ex_tasks).to eq(1)
    end

    it "should not be able to create a new task without a name" do
      fill_in('task_name', with: "")
      expect{
        click_and_wait('Tallenna')
      }.to change(Task, :count).by(0)

      expect(number_of_ex_tasks).to eq(0)
    end

    describe "when a task exists" do

      before :each do
        fill_in('task_name', with: "Soita asiakkaalle")
        click_and_wait('Tallenna')
      end

      it "should not be able to edit task without a name" do
        fill_in('task_name', with: "")
        click_and_wait('Päivitä')
        expect(page).to have_content 'Toimenpiteen päivitys epäonnistui.'

        expect(Task.where(level:1...999).first.name).to eq("Soita asiakkaalle")
      end

      describe "should be able to add a" do

        it "task text subtask" do
          click_and_wait('+ Teksti')

          fill_in_ckeditor 'task_text_content', with: 'Asiakas kertoo, että koira on kipeä.'

          expect{
            click_and_wait('Tallenna')
          }.to change(TaskText, :count).by(1)

          expect(page).to have_content 'Kysymys lisättiin onnistuneesti!'
          expect(Subtask.count).to eq(1)

          expect(Task.where(level:1...999).first.task_texts.first.content).to eq("<p>Asiakas kertoo, ett&auml; koira on kipe&auml;.</p>\r\n")
        end


        it "multichoice subtask" do

          click_and_wait('+ Monivalinta tai radio button')
          fill_in('multichoice_question', with: "Mitä kysyt asiakkaalta:")

          expect{
            click_and_wait('Tallenna')
          }.to change(Multichoice, :count).by(1)

          expect(page).to have_content 'Kysymys lisättiin onnistuneesti!'
          expect(Subtask.count).to eq(1)
          expect(Multichoice.first.question).to eq("Mitä kysyt asiakkaalta:")
          expect(Multichoice.first.subtask.task.name).to eq("Soita asiakkaalle")
        end
      end

      describe "should not be able to add a" do
        it "task text subtask without content" do

          click_and_wait('+ Teksti')

          fill_in_ckeditor 'task_text_content', with: ""

          expect{
            click_and_wait('Tallenna')
          }.to change(TaskText, :count).by(0)

          expect(page).to have_content 'Kysymyksen lisääminen epäonnistui!'
          expect(Subtask.count).to eq(0)
        end

        it "multichoice subtask without question" do

          click_and_wait('+ Monivalinta tai radio button')
          fill_in('multichoice_question', with: "")

          expect{
            click_and_wait('Tallenna')
          }.to change(Multichoice, :count).by(0)

          expect(page).to have_content 'Kysymyksen lisääminen epäonnistui!'
          expect(Subtask.count).to eq(0)
        end
      end

      describe "with task text subtask" do
        before :each do
          click_and_wait('+ Teksti')

          fill_in_ckeditor 'task_text_content', with: 'Asiakas kertoo, että koira on kipeä.'

          click_and_wait('Tallenna')
        end

        it "should be able to update the content of a task text" do

          fill_in_ckeditor 'task_text_content', with: 'Asiakas kertoo, että koira ei ole kipeä!'

          click_and_wait('Tallenna')

          expect(page).to have_content 'Kysymys päivitettiin onnistuneesti!'
          expect(Task.where(level:1...999).first.task_texts.first.content).to eq("<p>Asiakas kertoo, ett&auml; koira ei ole kipe&auml;!</p>\r\n")
        end

        it "should not be able to update task text to have no content" do
          fill_in_ckeditor 'task_text_content', with: ""

          click_and_wait('Tallenna')

          expect(page).to have_content 'Kysymyksen päivitys epäonnistui!'
        end
      end

      describe "with multichoice subtask" do
        before :each do
          click_and_wait('+ Monivalinta tai radio button')
          fill_in('multichoice_question', with: "Mitä kysyt asiakkaalta:")
          click_and_wait('Tallenna')
          expect(page).to have_content 'Muokkaa monivalintakysymystä'
        end

        it "should be able to update the question of a multichoice" do

          fill_in('multichoice_question', with: "Useita kysymyksiä asiakkaalle:")

          click_and_wait('Päivitä')

          expect(page).to have_content 'Kysymys päivitettiin onnistuneesti!'
          expect(Task.where(level:1...999).first.multichoices.first.question).to eq("Useita kysymyksiä asiakkaalle:")
        end

        it "should not be able to update multichoice to have no question" do
          fill_in('multichoice_question', with: "")

          click_and_wait('Päivitä')

          expect(page).to have_content 'Kysymyksen päivitys epäonnistui!'
          expect(Task.where(level:1...999).first.multichoices.first.question).to eq("Mitä kysyt asiakkaalta:")
        end

        it "should be able to add option to a multichoice" do
          fill_in('option_content', with: "Kysy taudeista")
          fill_in_ckeditor 'option_explanation', with: 'Taudeista on hyvä kysyä!'
          select('Pakollinen', from:'option[is_correct_answer]')

          expect{
            click_and_wait('Tallenna')
          }.to change(Option, :count).by(1)

          expect(page).to have_content 'Vaihtoehto lisättiin onnistuneesti'

          expect(Multichoice.first.options.first.content).to eq('Kysy taudeista')
          expect(Multichoice.first.options.first.explanation).to eq("<p>Taudeista on hyv&auml; kysy&auml;!</p>\r\n")
          expect(Multichoice.first.options.first.is_correct_answer).to eq("required")
        end

      end

      describe "with radiobutton subtask" do
        before :each do
          click_and_wait('+ Monivalinta tai radio button')
          fill_in('multichoice_question', with: "Onko tauti epidemia?")
          check 'multichoice_is_radio_button'
          click_and_wait('Tallenna')
          expect(page).to have_content 'Muokkaa monivalintakysymystä'
        end

        it "should be able to update the question of a radiobutton" do

          fill_in('multichoice_question', with: "Mahtaako olla epidemiaa liikkeellä?")

          click_and_wait('Päivitä')

          expect(page).to have_content 'Kysymys päivitettiin onnistuneesti!'
          expect(Task.where(level:1...999).first.multichoices.first.question).to eq("Mahtaako olla epidemiaa liikkeellä?")
        end

        it "should not be able to update radiobutton to have no question" do
          fill_in('multichoice_question', with: "")

          click_and_wait('Päivitä')

          expect(page).to have_content 'Kysymyksen päivitys epäonnistui!'
          expect(Task.where(level:1...999).first.multichoices.first.question).to eq("Onko tauti epidemia?")
        end

        describe "with options" do
          let!(:option1){FactoryGirl.create(:option, multichoice_id: 1, content: "Bakteerilääke", is_correct_answer: "wrong", explanation: "Ei oikein")}
          let!(:option2){FactoryGirl.create(:option, multichoice_id: 1, content: "Astmalääke", is_correct_answer: "allowed", explanation: "Ei oikea vastaus")}
          let!(:option3){FactoryGirl.create(:option, multichoice_id: 1, content: "Kurkkulääke", explanation: "Oikea vastaus")}

          before :each do
            click_and_wait("Toimenpiteet")
            click_and_wait("Soita asiakkaalle")
            click_and_wait("Radio button: Onko tauti epidemia?")
          end

          it "should be able to change the right option" do
            select('Pakollinen', from:'is_correct_answer_2')
            click_and_wait('save_2')

            expect(Option.find(1).is_correct_answer).to eq("wrong")
            expect(Option.find(2).is_correct_answer).to eq("required")
            expect(Option.find(3).is_correct_answer).to eq("allowed")
          end
        end
      end
    end
  end

  describe "student" do
    let!(:user){FactoryGirl.create(:user, admin: false)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
    end

    it "should not be able to visit new task page" do
      visit new_task_path
      expect(current_path).to eq(signin_path)
    end
  end

end

