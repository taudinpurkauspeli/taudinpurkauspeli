require 'rails_helper'

describe "Hypothesis list page" do

  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:hypothesis){FactoryGirl.create(:hypothesis)}
  let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis)}
  let!(:hypothesis_group){FactoryGirl.create(:hypothesis_group)}




  describe "if user is signed in as student" do

    let!(:user){FactoryGirl.create(:student)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      visit root_path

      click_button('Lihanautakuolemat')
      click_link('Työhypoteesit')
    end

    it "user should be able to view the hypotheses of an exercise" do
      expect(page).to have_button 'Bakteeritaudit'
      expect(page).to have_button 'Virustauti'
    end

    it "user should be able check hypotheses of an exercise" do
      click_button('Virustauti')
      expect(CheckedHypothesis.count).to eq(1)
      #   expect(page).to have_content 'Anamneesin mukaan tauti on virustauti'
    end
  end

  describe "if user is signed in as student" do

    let!(:user){FactoryGirl.create(:student)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      visit root_path
    end

    it "user should not be able to view the hypotheses of an exercise if no exercise has been chosen" do
      visit hypotheses_path

      expect(current_path).to eq(exercises_path)
      expect(page).to have_content("Valitse ensin case, jota haluat tarkastella!")
    end

  end

  describe "if user is signed in as teacher" do
    let!(:user){FactoryGirl.create(:user)}
    let!(:hyp){FactoryGirl.create(:banked_hypothesis)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")

      visit root_path

      click_button('Lihanautakuolemat')
      click_link('Työhypoteesit')
    end

    it "user should be able to create a new hypothesis" do
      fill_in('hypothesis_name', with: 'Sorkkaihottuma')
      expect {
        first(:button, 'Tallenna').click
      }.to change(Hypothesis, :count).by(1)
      expect(page).to have_button 'Sorkkaihottuma'
    end

    it "user should not be able to create a new hypothesis without name" do
      fill_in('hypothesis_name', with: '')
      expect {
        first(:button, 'Tallenna').click
      }.to change(Hypothesis, :count).by(0)
      expect(page).not_to have_button 'Sorkkaihottuma'
    end

    it "user should be able to create a new hypothesis group" do
      fill_in('hypothesis_group_name', with: 'Sorkkaeläinten ihotaudit')
      expect {
        all(:button, 'Tallenna')[1].click
      }.to change(HypothesisGroup, :count).by(1)
      expect(page).to have_button 'Sorkkaeläinten ihotaudit'
    end

    it "user should be able to add hypotheses to an exercise" do
      expect {
        click_button('Sorkkatauti')
      }.to change(ExerciseHypothesis, :count).by(1)
    end

    it "user should be able to edit the explanation of a hypothesis added to an exercise" do
      fill_in('exercise_hypothesis_explanation', with: 'Virus ei olekaan bakteeritauti')
      click_button('Päivitä')
      expect(ExerciseHypothesis.first.explanation).to include('Virus ei olekaan bakteeritauti')
    end
  end
end
