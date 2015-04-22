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

        fill_in('new_hypothesis_name_1', with: 'Sorkkaihottuma')
        expect {
          click_and_wait("save_new_hypothesis_for_group_1")
        }.to change(Hypothesis, :count).by(1)

        expect(Hypothesis.first.name).to eq('Sorkkaihottuma')
        expect(page).to have_button 'Sorkkaihottuma'
        expect(page).to have_content 'Hypoteesin luominen onnistui'
      end

      it "create a new hypothesis group" do
        click_and_wait('+ Uusi työhypoteesiryhmä')

        fill_in('hypothesis_group_name', with: 'Sorkkaeläinten ihotaudit')

        expect {
          click_and_wait("new_hypothesis_group")
        }.to change(HypothesisGroup, :count).by(1)

        expect(page).to have_button 'Sorkkaeläinten ihotaudit'
        expect(HypothesisGroup.last.name).to eq('Sorkkaeläinten ihotaudit')
      end

      it "add hypotheses to an exercise" do
        expect {
          click_and_wait('Sorkkatauti')
        }.to change(ExerciseHypothesis, :count).by(1)

        expect(ExerciseHypothesis.last.hypothesis.name).to eq('Sorkkatauti')
      end


      it "remove hypotheses from an exercise" do
        # backdoor = 0
        # while(ExerciseHypothesis.count != 0)
        #   if backdoor > 50 then
        #     raise "Loop error!"
        #   end

        #click_and_wait('Virustauti')
        find_button("Virustauti").trigger('click')
        wait_for_ajax
        wait_for_ckeditor("exercise_hypothesis_explanation_1")
        #click_and_wait('remove_from_case_1')
        find_button("remove_from_case_1").trigger('click')
        wait_for_ajax
        #  backdoor += 1
        #end
        expect(ExerciseHypothesis.count).to eq(0)
      end

      it "edit the explanation of a hypothesis added to an exercise" do
        # backdoor = 0
        # while(ExerciseHypothesis.first.explanation != "<p>Virus ei olekaan bakteeritauti</p>\r\n")
        #   if backdoor > 50 then
        #     raise "Loop error!"
        #   end

         # click_and_wait('Virustauti')
        find_button("Virustauti").trigger('click')
        wait_for_ajax
          wait_for_ckeditor("exercise_hypothesis_explanation_1")

          fill_in_ckeditor 'exercise_hypothesis_explanation_1', with: 'Virus ei olekaan bakteeritauti'

        #  click_and_wait("update_exercise_hypothesis_1")
        find_button("update_exercise_hypothesis_1").trigger('click')
        wait_for_ajax
        #  backdoor += 1
        #end

        expect(ExerciseHypothesis.first.explanation).to eq("<p>Virus ei olekaan bakteeritauti</p>\r\n")
      end

      it "add prerequisite task to a hypothesis added to an exercise" do
        # backdoor = 0
        # while(ExerciseHypothesis.first.task.name == task.name)
        #   if backdoor > 50 then
        #     raise "Loop error!"
        #   end

         # click_and_wait('Virustauti')

          find_button("Virustauti").trigger('click')
          wait_for_ajax
          wait_for_ckeditor("exercise_hypothesis_explanation_1")

          select('Asiakkaan soitto', from:'exercise_hypothesis[task_id]')

         # click_and_wait("update_exercise_hypothesis_1")
          find_button("update_exercise_hypothesis_1").trigger('click')
          wait_for_ajax
         # backdoor += 1
        #end
        expect(ExerciseHypothesis.first.task.name).to eq('Asiakkaan soitto')
      end

    end


    describe "should not be able to" do

      it " create a new hypothesis without a name" do
        click_and_wait('+ Uusi työhypoteesi')

        fill_in('new_hypothesis_name_1', with: '')
        expect {
          click_and_wait("save_new_hypothesis_for_group_1")
        }.to change(Hypothesis, :count).by(0)

        expect(page).to have_content 'Hypoteesin luominen epäonnistui'
      end

      it "create a new hypothesis group without a name" do
        click_and_wait('+ Uusi työhypoteesiryhmä')

        fill_in('hypothesis_group_name', with: '')
        expect {
          click_and_wait("new_hypothesis_group")
        }.to change(HypothesisGroup, :count).by(0)

        expect(page).to have_content 'Työhypoteesiryhmän luominen epäonnistui'
      end
    end

  end

end
