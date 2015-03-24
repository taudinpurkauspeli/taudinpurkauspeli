require 'rails_helper'

describe "Hypothesis list page", js:true do

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

    it "he should not be able to view the hypotheses of an exercise if exercise has not been chosen" do
      visit hypotheses_path
      expect(current_path).to eq(exercises_path)
      expect(page).to have_content("Valitse ensin case, jota haluat tarkastella!")
    end

    describe "and chooses an exercise" do

      before :each do
        click_button('Lihanautakuolemat')
        click_link('Työhypoteesit')
        wait_for_ajax
      end

      it "he should be able to view the hypotheses of an exercise" do
        expect(page).to have_button 'Bakteeritaudit'
        expect(page).to have_button 'Virustauti'
      end

      describe "and has not completed required task" do

        it "he should not be able check hypotheses of an exercise" do
          expect {
            click_button('Virustauti')
            wait_for_ajax
          }.to change(CheckedHypothesis, :count).by (0)
          expect(page).to have_content 'Sinulla ei ole vielä tarpeeksi tietoa voidaksesi poissulkea työhypoteesin.'
        end
      end

      describe "and has completed required task" do
        let!(:completed_task){FactoryGirl.create(:completed_task)}

        it "user should be able to check hypotheses of an exercise" do
          expect {
            click_button('Virustauti')
            wait_for_ajax
          }.to change(CheckedHypothesis, :count).by (1)
          expect(page).to have_content 'poissuljettu'
          expect(CheckedHypothesis.first.hypothesis.name).to eq('Virustauti')
        end
      end
    end

  end

  describe "if user is signed in as teacher" do
    let!(:user){FactoryGirl.create(:user)}
    let!(:hypothesis2){FactoryGirl.create(:banked_hypothesis)}
    let!(:task2){FactoryGirl.create(:task, name: "Asiakkaan soitto")}
    let!(:exercise_hypothesis2){FactoryGirl.create(:exercise_hypothesis, task_id:nil)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
      visit root_path
      click_button('Lihanautakuolemat')
      click_link('Työhypoteesit')
      wait_for_ajax
    end

    describe "he should be able to edit hypotheses and hypothesis groups" do

      it "user should be able to create a new hypothesis" do
        click_button('+ Uusi työhypoteesi')
        wait_for_ajax

        fill_in('hypothesis_name', with: 'Sorkkaihottuma')
        expect {
          first(:button, 'Tallenna').click
          wait_for_ajax
        }.to change(Hypothesis, :count).by(1)

        expect(Hypothesis.first.name).to eq('Sorkkaihottuma')
        expect(page).to have_button 'Sorkkaihottuma'
        expect(page).to have_content 'Hypoteesin luominen onnistui'
      end

      it "user should not be able to create a new hypothesis without a name" do
        click_button('+ Uusi työhypoteesi')
        wait_for_ajax

        fill_in('hypothesis_name', with: '')
        expect {
          first(:button, 'Tallenna').click
          wait_for_ajax
        }.to change(Hypothesis, :count).by(0)

        expect(page).to have_content 'Hypoteesin luominen epäonnistui'
      end

      it "user should be able to create a new hypothesis group" do
        click_button('+ Uusi työhypoteesiryhmä')
        wait_for_ajax

        fill_in('hypothesis_group_name', with: 'Sorkkaeläinten ihotaudit')

        expect {
          first(:button, 'Tallenna').click
          wait_for_ajax
        }.to change(HypothesisGroup, :count).by(1)

        expect(page).to have_button 'Sorkkaeläinten ihotaudit'
        expect(HypothesisGroup.last.name).to eq('Sorkkaeläinten ihotaudit')
      end

      it "user should not be able to create a new hypothesis group without a name" do
        click_button('+ Uusi työhypoteesiryhmä')
        wait_for_ajax

        fill_in('hypothesis_group_name', with: '')
        expect {
          first(:button, 'Tallenna').click
          wait_for_ajax
        }.to change(HypothesisGroup, :count).by(0)

        expect(page).to have_content 'Työhypoteesiryhmän luominen epäonnistui'
      end
    end

    describe "he should be able to manage hypotheses of an exercise" do

      it "user should be able to add hypotheses to an exercise" do
        expect {
          first(:button,'Sorkkatauti').click
          wait_for_ajax
        }.to change(ExerciseHypothesis, :count).by(1)

        expect(ExerciseHypothesis.last.hypothesis.name).to eq('Sorkkatauti')
      end

      it "user should be able to remove hypotheses from an exercise" do
        while(ExerciseHypothesis.count != 0)
          click_button('Virustauti')
          wait_for_ajax
          first(:button, 'Poista casesta').click
          wait_for_ajax
        end
      end

      it "user should be able to edit the explanation of a hypothesis added to an exercise" do
        while(ExerciseHypothesis.first.explanation != 'Virus ei olekaan bakteeritauti')

          click_button('Virustauti')
          wait_for_ajax

          fill_in('exercise_hypothesis_explanation', with: 'Virus ei olekaan bakteeritauti')
          first(:button, 'Päivitä').click
          wait_for_ajax

        end
      end

      it "user should be able to add prerequisite task to a hypothesis added to an exercise" do

        while(ExerciseHypothesis.first.task.nil?)
          click_button('Virustauti')
          wait_for_ajax

          select('Asiakkaan soitto', from:'exercise_hypothesis[task_id]')

          first(:button, 'Päivitä').click
          wait_for_ajax

        end
      end

    end

  end

end
