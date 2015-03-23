require 'rails_helper'

describe "Hypothesis list page" do

  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:hypothesis_group){FactoryGirl.create(:hypothesis_group)}
  let!(:hypothesis){FactoryGirl.create(:hypothesis)}
  let!(:task){FactoryGirl.create(:task)}

  describe "if user is signed in as student" do
    let!(:user){FactoryGirl.create(:student)}
    let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")
      visit root_path
    end

    it "user should not be able to view the hypotheses of an exercise if no exercise has been chosen" do
      visit hypotheses_path
      expect(current_path).to eq(exercises_path)
      expect(page).to have_content("Valitse ensin case, jota haluat tarkastella!")
    end

    describe "and chooses an exercise" do

      before :each do
        click_button('Lihanautakuolemat')
        click_link('Työhypoteesit')
      end

      it "user should be able to view the hypotheses of an exercise" do
        expect(page).to have_button 'Bakteeritaudit'
        expect(page).to have_button 'Virustauti'
      end

      describe "and has not completed required task" do

        it "user should not be able check hypotheses of an exercise" do
          expect {
            click_button('Virustauti')
          }.to change(CheckedHypothesis, :count).by (0)
        end
      end
    end

    describe "and has completed required task" do
      before :each do
        click_button('Lihanautakuolemat')
        click_link('Työhypoteesit')
      end
      it "user should be able to check hypotheses of an exercise" do
        user.completed_tasks.create task_id:1
        expect {
          click_button('Virustauti')
        }.to change(CheckedHypothesis, :count).by (1)
      end
    end
  end

  describe "if user is signed in as teacher" do
    let!(:user){FactoryGirl.create(:user)}
    let!(:hyp){FactoryGirl.create(:banked_hypothesis)}
    let!(:task2){FactoryGirl.create(:task, name: "Asiakkaan soitto")}
    let!(:exercise_hypothesis2){FactoryGirl.create(:exercise_hypothesis, task_id:nil)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
      visit root_path
      click_button('Lihanautakuolemat')
      click_link('Työhypoteesit')
    end

    describe "he should be able to edit hypotheses and hypothesis groups" do

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

    end

    describe "he should be able to manage hypotheses of an exercise" do
=begin
      it "user should be able to add hypotheses to an exercise" do
        expect {
          click_button('Sorkkatauti')
        }.to change(ExerciseHypothesis, :count).by(1)
      end
=end
      it "user should be able to edit the explanation of a hypothesis added to an exercise" do
        fill_in('exercise_hypothesis_explanation', with: 'Virus ei olekaan bakteeritauti')
        click_button('Päivitä')
        expect(ExerciseHypothesis.first.explanation).to include('Virus ei olekaan bakteeritauti')
      end

      it "user should be able to add prerequisite task to a hypothesis added to an exercise" do
        select('Asiakkaan soitto', from:'exercise_hypothesis[task_id]')
        click_button('Päivitä')
        expect(ExerciseHypothesis.first.task.name).to eq(task2.name)
      end

      it "user should be able to change prerequisite task of a hypothesis added to an exercise" do
        select('Asiakkaan soitto', from:'exercise_hypothesis[task_id]')
        click_button('Päivitä')
        expect(ExerciseHypothesis.first.task.name).to eq(task2.name)

        select('Soita asiakkaalle', from:'exercise_hypothesis[task_id]')
        click_button('Päivitä')
        expect(ExerciseHypothesis.first.task.name).to eq(task.name)

      end

    end

  end
end
