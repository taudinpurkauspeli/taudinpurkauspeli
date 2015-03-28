require 'rails_helper'

describe "Hypothesis list page", js:true do

  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:hypothesis_group){FactoryGirl.create(:hypothesis_group)}
  let!(:task){FactoryGirl.create(:task, exercise:exercise, level:1)}
  let!(:hypothesis){FactoryGirl.create(:hypothesis, hypothesis_group:hypothesis_group)}
  let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis, task:task)}

  describe "student" do
    let!(:user){FactoryGirl.create(:student)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")
      visit root_path
    end

    it "should not be able to view hypotheses of an unchosen exercise" do
      visit hypotheses_path
      expect(current_path).to eq(exercises_path)
      expect(page).to have_content("Valitse ensin case, jota haluat tarkastella!")
    end

    describe "has chosen an exercise" do

      before :each do
        click_and_wait('Lihanautakuolemat')
        click_and_wait('Työhypoteesit')
      end

      it "then he should be able to view the hypotheses of an exercise" do
        expect(page).to have_button 'Bakteeritaudit'
        expect(page).to have_button 'Virustauti'
      end

      describe "but not completed required task" do

        it "then he should not be able check hypotheses of an exercise" do
          expect {
            click_and_wait('Virustauti')
          }.to change(CheckedHypothesis, :count).by (0)
          expect(page).to have_content 'Sinulla ei ole vielä tarpeeksi tietoa voidaksesi poissulkea työhypoteesin.'
        end
      end

      describe "and has completed required task" do
        it "then he should be able to check hypotheses of an exercise" do
          user.completed_tasks.create task_id:task.id
          expect {
            click_and_wait('Virustauti')
          }.to change(CheckedHypothesis, :count).by (1)
        end
      end
    end

  end

  describe "teacher" do
    let!(:user){FactoryGirl.create(:user)}
    let!(:hyp){FactoryGirl.create(:banked_hypothesis, hypothesis_group:hypothesis_group)}
    let!(:task2){FactoryGirl.create(:task, name: "Asiakkaan soitto", exercise_id:exercise.id)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
      visit root_path
      click_and_wait('Lihanautakuolemat')
      click_and_wait('Työhypoteesit')
    end

    describe "should be able to" do

      it "create a new hypothesis" do
        click_and_wait('+ Uusi työhypoteesi')

        fill_in('hypothesis_name', with: 'Sorkkaihottuma')
        expect {
          first(:button, 'Tallenna').click
          wait_for_ajax
        }.to change(Hypothesis, :count).by(1)

        expect(Hypothesis.first.name).to eq('Sorkkaihottuma')
        expect(page).to have_button 'Sorkkaihottuma'
        expect(page).to have_content 'Hypoteesin luominen onnistui'
      end

      it "create a new hypothesis group" do
        click_and_wait('+ Uusi työhypoteesiryhmä')

        fill_in('hypothesis_group_name', with: 'Sorkkaeläinten ihotaudit')

        expect {
          first(:button, 'Tallenna').click
          wait_for_ajax
        }.to change(HypothesisGroup, :count).by(1)

        expect(page).to have_button 'Sorkkaeläinten ihotaudit'
        expect(HypothesisGroup.last.name).to eq('Sorkkaeläinten ihotaudit')
      end

      it "add hypotheses to an exercise" do
        expect {
          first(:button,'Sorkkatauti').click
          wait_for_ajax
        }.to change(ExerciseHypothesis, :count).by(1)

        expect(ExerciseHypothesis.last.hypothesis.name).to eq('Sorkkatauti')
      end

      it "remove hypotheses from an exercise" do
        while(ExerciseHypothesis.count != 0)
          click_and_wait('Virustauti')
          first(:button, 'Poista casesta').click
          wait_for_ajax
        end
      end

      it "edit the explanation of a hypothesis added to an exercise" do
        while(ExerciseHypothesis.first.explanation != 'Virus ei olekaan bakteeritauti')

          click_and_wait('Virustauti')

          fill_in('exercise_hypothesis_explanation', with: 'Virus ei olekaan bakteeritauti')
          first(:button, 'Päivitä').click
          wait_for_ajax

        end
      end

      it "add prerequisite task to a hypothesis added to an exercise" do

        while(ExerciseHypothesis.first.task.nil?)
          click_and_wait('Virustauti')

          select('Asiakkaan soitto', from:'exercise_hypothesis[task_id]')

          first(:button, 'Päivitä').click
          wait_for_ajax

        end
      end
    end

    describe "should not be able to" do

      it " create a new hypothesis without a name" do
        click_and_wait('+ Uusi työhypoteesi')

        fill_in('hypothesis_name', with: '')
        expect {
          first(:button, 'Tallenna').click
          wait_for_ajax
        }.to change(Hypothesis, :count).by(0)

        expect(page).to have_content 'Hypoteesin luominen epäonnistui'
      end

      it "create a new hypothesis group without a name" do
        click_and_wait('+ Uusi työhypoteesiryhmä')

        fill_in('hypothesis_group_name', with: '')
        expect {
          first(:button, 'Tallenna').click
          wait_for_ajax
        }.to change(HypothesisGroup, :count).by(0)

        expect(page).to have_content 'Työhypoteesiryhmän luominen epäonnistui'
      end
    end


  end

end
