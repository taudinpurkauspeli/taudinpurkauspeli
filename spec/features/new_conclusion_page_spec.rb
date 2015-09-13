require 'rails_helper'

describe "New Task page", js:true do
  let!(:exercise){FactoryGirl.create(:exercise)}

  let!(:hypothesis){FactoryGirl.create(:hypothesis)}
  let!(:hypothesis2){FactoryGirl.create(:hypothesis, name: "Bakteeritauti")}

  let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, exercise: exercise, hypothesis: hypothesis)}
  let!(:exercise_hypothesis2){FactoryGirl.create(:exercise_hypothesis, exercise: exercise, hypothesis: hypothesis2)}

  describe "teacher" do
    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
      visit root_path
      wait_for_ajax
      expect(page).to have_button('Lihanautakuolemat')
      click_and_wait(exercise.name)
      expect(page).to have_content('Lihanautakuolemat')
      wait_and_trigger_click('Toimenpiteet')
      click_and_wait('+ Luo diagnoositoimenpide')
    end

    describe "should be able to add new conclusion" do

      it "with all fields filled in" do

        fill_in('conclusion_title', with: "Diagnoositoimenpide")

        fill_in_ckeditor 'conclusion_content', with: 'Valitse oikea diagnoosi!'

        select('Virustauti', from:'conclusion[exercise_hypothesis_id]')

        expect{
          click_and_wait('Tallenna')
        }.to change(Conclusion, :count).by(1)

        expect(page).to have_content 'Diagnoositoimenpide lisättiin onnistuneesti!'
        expect(Subtask.count).to eq(1)

        expect(Conclusion.first.title).to eq("Diagnoositoimenpide")
        expect(Conclusion.first.exercise_hypothesis_id).to eq(1)
        expect(Task.where(level:1...999).first.name).to eq("Diagnoositoimenpide")
        expect(Task.where(level:1...999).first.conclusions.first.content).to eq("<p>Valitse oikea diagnoosi!</p>\r\n")
      end

      it "without a right exercise hypothesis" do

        fill_in('conclusion_title', with: "Diagnoositoimenpide")

        fill_in_ckeditor 'conclusion_content', with: 'Valitse oikea diagnoosi!'

        expect{
          click_and_wait('Tallenna')
        }.to change(Conclusion, :count).by(1)

        expect(page).to have_content 'Diagnoositoimenpide lisättiin onnistuneesti!'
        expect(Subtask.count).to eq(1)

        expect(Conclusion.first.title).to eq("Diagnoositoimenpide")
        expect(Task.where(level:1...999).first.name).to eq("Diagnoositoimenpide")
        expect(Task.where(level:1...999).first.conclusions.first.content).to eq("<p>Valitse oikea diagnoosi!</p>\r\n")
      end

      it "without content" do

        fill_in('conclusion_title', with: "Diagnoositoimenpide")

        select('Virustauti', from:'conclusion[exercise_hypothesis_id]')

        expect{
          click_and_wait('Tallenna')
        }.to change(Conclusion, :count).by(1)

        expect(page).to have_content 'Diagnoositoimenpide lisättiin onnistuneesti!'
        expect(Subtask.count).to eq(1)

        expect(Conclusion.first.title).to eq("Diagnoositoimenpide")
        expect(Conclusion.first.exercise_hypothesis_id).to eq(1)
        expect(Task.where(level:1...999).first.name).to eq("Diagnoositoimenpide")
      end

    end

    describe "should not be able to add new conclusion" do

      it "without a title" do

        select('Virustauti', from:'conclusion[exercise_hypothesis_id]')

        fill_in_ckeditor 'conclusion_content', with: 'Valitse oikea diagnoosi!'

        expect{
          click_and_wait('Tallenna')
        }.to change(Conclusion, :count).by(0)

        expect(page).to have_content 'Diagnoositoimenpiteen lisääminen epäonnistui!'
        expect(Subtask.count).to eq(0)
        expect(Task.count).to eq(1)

      end

    end

    describe "with conclusion subtask" do

      before :each do

        fill_in('conclusion_title', with: "Diagnoositoimenpide")

        fill_in_ckeditor 'conclusion_content', with: 'Valitse oikea diagnoosi!'

        select('Virustauti', from:'conclusion[exercise_hypothesis_id]')

        click_and_wait('Tallenna')
      end

      describe "should be able to" do

        it "delete conclusion task" do

          expect{
            click_and_wait('Poista')
          }.to change(Conclusion, :count).by(-1)

          expect(page).to have_content 'Diagnoositoimenpide poistettu!'
          expect(Subtask.count).to eq(0)
          expect(Task.count).to eq(1)

        end

        it "preview the conclusion" do

          click_and_wait('Esikatsele')

          expect(page).to have_content "Diagnoositoimenpide"
          expect(page).to have_content "Tehtäväsi:"
          expect(page).to have_content "Valitse oikea diagnoosi!"
          expect(page).to have_content "Jäljellä olevat työhypoteesit:"
          expect(page).to have_content "Onnittelut! Sait selville, että kyseessä oli Virustauti. Mitä sinun tulee vielä tehdä?"
          expect(page).to have_content "Oikea diagnoosi:"
          expect(page).to have_button "Virustauti"

        end

        describe "update" do

          it "the title of conclusion" do

            fill_in('conclusion_title', with: "Diagnoosisi")

            click_and_wait('Tallenna')
            expect(page).to have_content 'Diagnoositoimenpide päivitettiin onnistuneesti!'
            expect(Conclusion.first.title).to eq("Diagnoosisi")
            expect(Task.where(level:1...999).first.name).to eq("Diagnoosisi")
          end

          it "the contents of conclusion" do

            fill_in_ckeditor 'conclusion_content', with: 'Diagnoosin valinta!'
            click_and_wait('Tallenna')
            expect(page).to have_content 'Diagnoositoimenpide päivitettiin onnistuneesti!'
            expect(Task.where(level:1...999).first.conclusions.first.content).to eq("<p>Diagnoosin valinta!</p>\r\n")

          end

          it "the right exercise hypothesis of conclusion" do
            select('Bakteeritauti', from:'conclusion[exercise_hypothesis_id]')
            click_and_wait('Tallenna')
            expect(page).to have_content 'Diagnoositoimenpide päivitettiin onnistuneesti!'
            expect(Conclusion.first.exercise_hypothesis_id).to eq(2)

          end

        end
      end

      it "should not be able to update conclusion to have no title" do
        fill_in('conclusion_title', with: "")

        click_and_wait('Tallenna')
        expect(page).to have_content 'Diagnoosioimenpiteen päivitys epäonnistui!'
        expect(Conclusion.first.title).to eq("Diagnoositoimenpide")
      end

    end
  end
end

