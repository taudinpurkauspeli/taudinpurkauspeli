require 'rails_helper'

describe "Multichoice page for student" do

  let!(:exercise){FactoryGirl.create(:exercise)}

  let!(:multichoice_task){FactoryGirl.create(:task, name: "Valitse kenelle soitat")}
  let!(:multichoice_subtask){FactoryGirl.create(:subtask)}
  let!(:multichoice){FactoryGirl.create(:multichoice)}
  let!(:option){FactoryGirl.create(:option)}
  let!(:option2){FactoryGirl.create(:option, content: "Ei tykkää", value: false, explanation: "Ei oikea vastaus")}
  let!(:option3){FactoryGirl.create(:option, content: "Ehkä tykkää", explanation: "Melkein oikea vastaus")}


  describe "if student is signed in" do

    let!(:user){FactoryGirl.create(:student)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      visit root_path

      click_button('Lihanautakuolemat')
      click_link('Toimenpiteet')
      click_button(multichoice_task.name)

    end

    it "he should be able to complete multichoice task with right options selected" do
      check 'checked_options_1'
      check 'checked_options_3'
      expect {
        click_button('Tarkista')
      }.to change(CompletedTask, :count).by(1)

      expect(page).to have_content 'Valitsit oikein!'
      expect(page).to have_content option.explanation
      expect(page).to have_content option2.explanation
      expect(page).to have_content option3.explanation
    end


    it "he should not be able to complete multichoice task without any options selected" do

      expect {
        click_button('Tarkista')
      }.not_to change(CompletedTask, :count)

      expect(page).to have_content 'Valinnoissa oli vielä virheitä!'
    end

    it "he should not be able to complete multichoice task with wrong options selected" do

      check 'checked_options_1'
      check 'checked_options_2'
      check 'checked_options_3'

      expect {
        click_button('Tarkista')
      }.not_to change(CompletedTask, :count)

      expect(page).to have_content 'Valinnoissa oli vielä virheitä!'
    end

    it "he should not be able to complete multichoice task when not all right options are selected" do

      check 'checked_options_1'

      expect {
        click_button('Tarkista')
      }.not_to change(CompletedTask, :count)

      expect(page).to have_content 'Valinnoissa oli vielä virheitä!'
    end


    describe "after completing multichoice task" do

      before :each do
        check 'checked_options_1'
        check 'checked_options_3'
        click_button('Tarkista')
        click_link('Toimenpiteet')
        click_button(multichoice_task.name)
      end

      it "he should be able to view options and explanations of multichoice" do
        expect(page).to have_content option.content
        expect(page).to have_content option2.content
        expect(page).to have_content option3.content

        expect(page).to have_content option.explanation
        expect(page).to have_content option2.explanation
        expect(page).to have_content option3.explanation
      end

    end


  end
end
