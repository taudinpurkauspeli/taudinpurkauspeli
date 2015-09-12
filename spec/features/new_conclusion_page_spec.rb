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

    describe "should be able to" do

      it "add new conclusion" do

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

      it "preview the conclusion" do

      end

    end

    describe "should not be able to add new conclusion" do

      it "without a right exercise hypothesis" do

      end

      it "without a title" do

      end

      it "without a content" do

      end


    end


    # TODO: Specs for updating and deleting and previewing conclusion

  end

end

