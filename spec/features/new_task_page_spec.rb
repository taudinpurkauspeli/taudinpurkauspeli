require 'rails_helper'

describe "New Task page", js:true do
  let!(:exercise){FactoryGirl.create(:exercise)}

  describe "teacher" do
    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
      visit exercises_path
      wait_for_ajax
      expect(page).to have_button('Lihanautakuolemat')
      wait_and_trigger_click(exercise.name)
      expect(page).to have_content('Lihanautakuolemat')
      wait_and_trigger_click('Toimenpiteet')
      wait_and_trigger_click('+ Luo uusi toimenpide')
    end

    it "should be able to create a new task without a subtask" do
      fill_in('task_name', with: "Soita asiakkaalle")
      expect {
        wait_and_trigger_click('Tallenna')
      }.to change(Task, :count).by(1)

      expect(page).to have_content 'Toimenpide luotiin onnistuneesti.'
      expect(number_of_ex_tasks).to eq(1)
    end

    it "should not be able to create a new task without a name" do
      fill_in('task_name', with: "")
      expect{
        wait_and_trigger_click('Tallenna')
      }.to change(Task, :count).by(0)

      expect(number_of_ex_tasks).to eq(0)
    end


    describe "when a task exists" do

      before :each do
        fill_in('task_name', with: "Soita asiakkaalle")
        wait_and_trigger_click('Tallenna')
      end

      it "should not be able to edit task without a name" do
        fill_in('task_name', with: "")
        wait_and_trigger_click('Päivitä')
        expect(page).to have_content 'Toimenpiteen päivitys epäonnistui.'

        expect(Task.where(level:1...999).first.name).to eq("Soita asiakkaalle")
      end

      describe "should be able to add a" do

        it "task text subtask" do
          wait_and_trigger_click('+ Teksti')
          fill_in('task_text_content', with: 'Asiakas kertoo, että koira on kipeä.')

          expect{
            wait_and_trigger_click('Tallenna')
          }.to change(TaskText, :count).by(1)

          expect(page).to have_content 'Kysymys lisättiin onnistuneesti!'
          expect(Subtask.count).to eq(1)

          expect(Task.where(level:1...999).first.task_texts.first.content).to eq("<p>Asiakas kertoo, ett&auml; koira on kipe&auml;.</p>\r\n")
        end


        it "multichoice subtask" do

          wait_and_trigger_click('+ Monivalinta tai radio button')
          fill_in('multichoice_question', with: "Mitä kysyt asiakkaalta:")

          expect{
            wait_and_trigger_click('Tallenna')
          }.to change(Multichoice, :count).by(1)

          expect(page).to have_content 'Kysymys lisättiin onnistuneesti!'
          expect(Subtask.count).to eq(1)
          expect(Multichoice.first.question).to eq("Mitä kysyt asiakkaalta:")
          expect(Multichoice.first.subtask.task.name).to eq("Soita asiakkaalle")
        end

        it "interview subtask" do

          wait_and_trigger_click('+ Pohdinta')
          fill_in('interview_title', with: "Asiakkaan haastattelu")

          expect{
            wait_and_trigger_click('Tallenna')
          }.to change(Interview, :count).by(1)

          expect(page).to have_content 'Pohdinta lisättiin onnistuneesti!'
          expect(Subtask.count).to eq(1)
          expect(Interview.first.title).to eq("Asiakkaan haastattelu")
          expect(Interview.first.subtask.task.name).to eq("Soita asiakkaalle")
        end
      end

      describe "should not be able to add a" do
        it "task text subtask without content" do

          wait_and_trigger_click('+ Teksti')
          fill_in('task_text_content', with: "")

          expect{
            wait_and_trigger_click('Tallenna')
          }.to change(TaskText, :count).by(0)

          expect(page).to have_content 'Kysymyksen lisääminen epäonnistui!'
          expect(Subtask.count).to eq(0)
        end

        it "multichoice subtask without question" do

          wait_and_trigger_click('+ Monivalinta tai radio button')
          fill_in('multichoice_question', with: "")

          expect{
            wait_and_trigger_click('Tallenna')
          }.to change(Multichoice, :count).by(0)

          expect(page).to have_content 'Kysymyksen lisääminen epäonnistui!'
          expect(Subtask.count).to eq(0)
        end

        it "interview subtask without title" do

          wait_and_trigger_click('+ Pohdinta')
          fill_in('interview_title', with: "")

          expect{
            wait_and_trigger_click('Tallenna')
          }.to change(Interview, :count).by(0)

          expect(page).to have_content 'Pohdinnan lisääminen epäonnistui!'
          expect(Subtask.count).to eq(0)
        end
      end

      describe "with task text subtask" do
        before :each do
          wait_and_trigger_click('+ Teksti')
          fill_in('task_text_content', with: 'Asiakas kertoo, että koira on kipeä.')

          wait_and_trigger_click('Tallenna')
        end

        it "should be able to update the content of a task text" do
          fill_in('task_text_content', with: 'Asiakas kertoo, että koira ei ole kipeä!')

          wait_and_trigger_click('Tallenna')

          expect(page).to have_content 'Kysymys päivitettiin onnistuneesti!'
          expect(Task.where(level:1...999).first.task_texts.first.content).to eq("<p>Asiakas kertoo, ett&auml; koira ei ole kipe&auml;!</p>\r\n")
        end

        it "should not be able to update task text to have no content" do
          fill_in('task_text_content', with: "")

          wait_and_trigger_click('Tallenna')

          expect(page).to have_content 'Kysymyksen päivitys epäonnistui!'
        end
      end

      describe "with multichoice subtask" do
        before :each do
          wait_and_trigger_click('+ Monivalinta tai radio button')
          fill_in('multichoice_question', with: "Mitä kysyt asiakkaalta:")
          wait_and_trigger_click('Tallenna')
          expect(page).to have_content 'Monivalintakysymyksen muokkaus'
        end

        it "should be able to update the question of a multichoice" do

          fill_in('multichoice_question', with: "Useita kysymyksiä asiakkaalle:")

          wait_and_trigger_click('Päivitä')

          expect(page).to have_content 'Kysymys päivitettiin onnistuneesti!'
          expect(Task.where(level:1...999).first.multichoices.first.question).to eq("Useita kysymyksiä asiakkaalle:")
        end

        it "should not be able to update multichoice to have no question" do
          fill_in('multichoice_question', with: "")

          wait_and_trigger_click('Päivitä')

          expect(page).to have_content 'Kysymyksen päivitys epäonnistui!'
          expect(Task.where(level:1...999).first.multichoices.first.question).to eq("Mitä kysyt asiakkaalta:")
        end

        it "should be able to add option to a multichoice" do
          fill_in('option_content', with: "Kysy taudeista")
          fill_in('option_explanation', with: 'Taudeista on hyvä kysyä!')
          select('Pakollinen vaihtoehto', from:'option[is_correct_answer]')

          expect{
            wait_and_trigger_click('Tallenna')
          }.to change(Option, :count).by(1)

          expect(page).to have_content 'Vaihtoehto lisättiin onnistuneesti'

          expect(Multichoice.first.options.first.content).to eq('Kysy taudeista')
          expect(Multichoice.first.options.first.explanation).to eq("<p>Taudeista on hyv&auml; kysy&auml;!</p>\r\n")
          expect(Multichoice.first.options.first.is_correct_answer).to eq("required")
        end

      end

      describe "with radiobutton subtask" do
        before :each do
          wait_and_trigger_click('+ Monivalinta tai radio button')
          fill_in('multichoice_question', with: "Onko tauti epidemia?")
          check 'multichoice_is_radio_button'
          wait_and_trigger_click('Tallenna')
          expect(page).to have_content 'Monivalintakysymyksen muokkaus'
        end

        it "should be able to update the question of a radiobutton" do

          fill_in('multichoice_question', with: "Mahtaako olla epidemiaa liikkeellä?")

          wait_and_trigger_click('Päivitä')

          expect(page).to have_content 'Kysymys päivitettiin onnistuneesti!'
          expect(Task.where(level:1...999).first.multichoices.first.question).to eq("Mahtaako olla epidemiaa liikkeellä?")
        end

        it "should not be able to update radiobutton to have no question" do
          fill_in('multichoice_question', with: "")

          wait_and_trigger_click('Päivitä')

          expect(page).to have_content 'Kysymyksen päivitys epäonnistui!'
          expect(Task.where(level:1...999).first.multichoices.first.question).to eq("Onko tauti epidemia?")
        end

        describe "with options" do
          let!(:option1){FactoryGirl.create(:option, multichoice_id: 1, content: "Bakteerilääke", is_correct_answer: "wrong", explanation: "Ei oikein")}
          let!(:option2){FactoryGirl.create(:option, multichoice_id: 1, content: "Astmalääke", is_correct_answer: "allowed", explanation: "Ei oikea vastaus")}
          let!(:option3){FactoryGirl.create(:option, multichoice_id: 1, content: "Kurkkulääke", explanation: "Oikea vastaus")}

          before :each do
            wait_and_trigger_click("Toimenpiteet")
            wait_and_trigger_click("Soita asiakkaalle")
            wait_and_trigger_click("Radio button: Onko tauti epidemia?")
          end

          describe "should be able to change" do

            it "the right option" do
              wait_and_trigger_click("collapse-option-link2")

              select('Pakollinen vaihtoehto', from:'option_is_correct_answer_2')
              wait_and_trigger_click('option_save_2')

              expect(Option.find(1).is_correct_answer).to eq("wrong")
              expect(Option.find(2).is_correct_answer).to eq("required")
              expect(Option.find(3).is_correct_answer).to eq("allowed")
            end

            it "the content of an option" do
              wait_and_trigger_click("collapse-option-link2")

              fill_in('option_content_2', with: "Kysy taudeista lisätietoja")
              wait_and_trigger_click('option_save_2')

              expect(Option.find(2).content).to eq("Kysy taudeista lisätietoja")
            end

            it "the explanation of an option" do
              wait_and_trigger_click("collapse-option-link2")
              fill_in('option_explanation_2', with: 'Taudista pitää kerätä lisätietoja!')
              wait_and_trigger_click('option_save_2')

              expect(Option.find(2).explanation).to eq("<p>Taudista pit&auml;&auml; ker&auml;t&auml; lis&auml;tietoja!</p>\r\n")
            end
          end

        end
      end

      describe "with interview subtask" do
        before :each do
          wait_and_trigger_click('+ Pohdinta')
          fill_in('interview_title', with: "Kysymyksiä asiakkaalle")
          wait_and_trigger_click('Tallenna')
          expect(page).to have_content 'Pohdintatehtävän muokkaus'
        end

        describe "should be able to" do

          it "update the title of an interview" do

            fill_in('interview_title', with: "Paljon kysymyksiä asiakkaalle")

            wait_and_trigger_click('Päivitä')

            expect(page).to have_content 'Pohdinta päivitettiin onnistuneesti!'
            expect(Task.where(level:1...999).first.interviews.first.title).to eq("Paljon kysymyksiä asiakkaalle")
          end

          it "add question without a question group to an interview" do
            fill_in('question_title', with: "Onko eläin ollut kipea?")
            fill_in('question_content', with: 'On ollut kipeä.')
            select('Pakollinen kysymys', from:'question[required]')

            expect{
              wait_and_trigger_click('Tallenna')
            }.to change(Question, :count).by(1)

            expect(page).to have_content 'Kysymys lisättiin onnistuneesti'

            expect(QuestionGroup.count).to eq(0)
            expect(Interview.first.questions.first.title).to eq('Onko eläin ollut kipea?')
            expect(Interview.first.questions.first.content).to eq("<p>On ollut kipe&auml;.</p>\r\n")
            expect(Interview.first.questions.first.required).to eq("required")
          end

          it "add question with a question group to an interview" do
            fill_in('question_title', with: "Onko eläin ollut kipeä?")
            fill_in('question_content', with: 'On ollut kipeä.')
            select('Pakollinen kysymys', from:'question[required]')
            fill_in('question_question_group_attributes_title', with: "Eläinkysymys")

            expect{
              wait_and_trigger_click('Tallenna')
            }.to change(Question, :count).by(1)

            expect(QuestionGroup.count).to eq(1)
            expect(page).to have_content 'Kysymys lisättiin onnistuneesti'

            expect(Interview.first.questions.first.question_group.title).to eq("Eläinkysymys")
          end
        end

        it "should not be able to update interview to have no title" do
          fill_in('interview_title', with: "")

          wait_and_trigger_click('Päivitä')

          expect(page).to have_content 'Pohdinnan päivitys epäonnistui!'
          expect(Task.where(level:1...999).first.interviews.first.title).to eq("Kysymyksiä asiakkaalle")
        end

        describe "with questions" do
          let!(:question_group){FactoryGirl.create(:question_group)}
          let!(:question1){FactoryGirl.create(:question, interview_id: 1, title: "Sääolosuhteet", required: "wrong", content: "Sää oli normaali")}
          let!(:question2){FactoryGirl.create(:question, interview_id: 1, title: "Laidunolosuhteet", required: "allowed", content: "Laidun on puhdas")}
          let!(:question3){FactoryGirl.create(:question, interview_id: 1, title: "Karsinaolosuhteet", content: "Siivoton karsina")}
          let!(:question4){FactoryGirl.create(:question, interview_id: 1, title: "Ulko-olosuhteet", content: "Likainen laidun", question_group_id: 1)}

          before :each do
            wait_and_trigger_click("Toimenpiteet")
            wait_and_trigger_click("Soita asiakkaalle")
            wait_and_trigger_click("Pohdinta: Kysymyksiä asiakkaalle")
          end

          describe "should be able to" do
            it "change the required status of a question" do
              wait_and_trigger_click("collapse-question-link2")
              select('Pakollinen kysymys', from:'question_required_2')
              wait_and_trigger_click('question_save_2')

              expect(Question.find(2).required).to eq("required")
            end

            it "change the content of a question" do
              wait_and_trigger_click("collapse-question-link2")
              fill_in('question_content_2', with: 'On ollut todella kipeä!')
              wait_and_trigger_click('question_save_2')

              expect(Question.find(2).content).to eq("<p>On ollut todella kipe&auml;!</p>\r\n")
            end

            it "change the title of a question" do
              wait_and_trigger_click("collapse-question-link2")
              fill_in('question_title_2', with: "Miten eläin on voinut")
              wait_and_trigger_click('question_save_2')

              expect(Question.find(2).title).to eq("Miten eläin on voinut")
            end

            it "add question group to a question" do
              wait_and_trigger_click("collapse-question-link2")
              fill_in('question_question_group_attributes_title_2', with: "Eläinkysymys")
              wait_and_trigger_click('question_save_2')

              expect(QuestionGroup.count).to eq(2)
              expect(QuestionGroup.last.questions.count).to eq(1)
              expect(QuestionGroup.last.questions.first.title).to eq("Laidunolosuhteet")
              expect(Question.find(2).question_group.title).to eq("Eläinkysymys")
            end

            it "add same question group to many questions" do
              wait_and_trigger_click("collapse-question-link2")
              fill_in('question_question_group_attributes_title_2', with: "Lehmätaudit")
              wait_and_trigger_click('question_save_2')

              expect(QuestionGroup.count).to eq(1)
              expect(QuestionGroup.last.questions.count).to eq(2)
              expect(QuestionGroup.last.questions.first.title).to eq("Laidunolosuhteet")
              expect(Question.find(2).question_group.title).to eq("Lehmätaudit")
            end

            it "remove question group from a question" do
              wait_and_trigger_click("collapse-question-link4")
              fill_in('question_question_group_attributes_title_4', with: "")
              wait_and_trigger_click('question_save_4')

              expect(QuestionGroup.count).to eq(0)
              expect(QuestionGroup.find_by(title: "Lehmätaudit")).to eq(nil)
              expect(Question.find(4).question_group).to eq(nil)
            end
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
      expect(current_path).to eq(exercises_path)
    end
  end

end

