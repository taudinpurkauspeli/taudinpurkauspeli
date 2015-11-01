require 'rails_helper'

describe "Conclusion page for student", js:true do

  let!(:exercise){FactoryGirl.create(:exercise)}

  let!(:user){FactoryGirl.create(:student)}

  let!(:task){FactoryGirl.create(:task, exercise:exercise, level:1)}

  let!(:hypothesis_group){FactoryGirl.create(:hypothesis_group)}
  let!(:hypothesis_group2){FactoryGirl.create(:hypothesis_group, name: "Virustaudit")}

  let!(:hypothesis){FactoryGirl.create(:hypothesis, name: "Bakteeritauti", hypothesis_group:hypothesis_group)}
  let!(:hypothesis2){FactoryGirl.create(:hypothesis, name: "Kurkkukipu", hypothesis_group:hypothesis_group2)}
  let!(:hypothesis3){FactoryGirl.create(:hypothesis, hypothesis_group:hypothesis_group2)}

  let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis, task:task, explanation:"Bakteeritauti on tosiaan kyseessä!")}
  let!(:exercise_hypothesis2){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis2, task:task, explanation:"Kurkkukipu ei aiheuta tällaisia oireita!")}
  let!(:exercise_hypothesis3){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis3, task:task, explanation:"")}

  let!(:conclusion_task){FactoryGirl.create(:task, name: "Diagnoosi", exercise_id:exercise.id)}
  let!(:conclusion_subtask){FactoryGirl.create(:subtask, task_id:conclusion_task.id)}
  let!(:conclusion){FactoryGirl.create(:conclusion, title: "Diagnoosi", exercise_hypothesis_id:exercise_hypothesis.id, subtask_id:conclusion_subtask.id)}

  let!(:additional_dummy_task_to_prevent_ex_completion){FactoryGirl.create(:task, name:"Dummy task", exercise:exercise)}

  describe "student" do

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      wait_and_trigger_click('Lihanautakuolemat')
      wait_and_trigger_click('Toimenpiteet')
      wait_and_trigger_click(conclusion_task.name)
    end

    describe "should be able to see" do

      it "the title and the content of the conclusion" do

        expect(page).to have_content "Diagnoosi"
        expect(page).to have_content "Diffilistassa jäljellä:"
      end

      it "all remaining hypotheses" do
        expect(page).to have_button "Bakteeritauti"
        expect(page).to have_button "Kurkkukipu"
        expect(page).to have_button "Virustauti"
      end

      describe "all hypotheses after" do

        it "checking one wrong hypothesis" do
          wait_and_trigger_click("Kurkkukipu")
          expect(page).to have_button "Bakteeritauti"
          expect(page).to have_button "Kurkkukipu"
          expect(page).to have_button "Virustauti"
        end

        it "checking the right hypothesis" do
          wait_and_trigger_click("Bakteeritauti")
          expect(page).to have_button "Bakteeritauti"
          expect(page).to have_button "Kurkkukipu"
          expect(page).to have_button "Virustauti"
        end

      end

    end

    describe "should be able to complete conclusion task after clicking" do
      it "directly the right answer" do

        expect {
          wait_and_trigger_click("Bakteeritauti")
        }.to change(CompletedTask, :count).by(1)

        expect(page).to have_content "Hyvä, selvitit oikean diagnoosin!"
        expect(page).to have_content "Onnittelut! Sait selville, että kyseessä oli Bakteeritauti. Mitä sinun tulee vielä tehdä?"
        expect(page).to have_content 'Toimenpide suoritettu!'
        expect(page).to have_content 'Nyt voit mennä suorittamaan lisää toimenpiteitä.'
        expect(page).to have_content 'Poissuljetut diffit:'
        expect(page).not_to have_content 'poissulkemaan diffejä tai'

        expect(page).to have_button 'Toimenpidelista'
        expect(page).not_to have_button 'Diffilista'
      end


      it "one wrong answer" do
        expect {
          wait_and_trigger_click("Kurkkukipu")
        }.not_to change(CompletedTask, :count)

        expect(page).to have_content "Väärä diffi poissuljettu!"

        expect {
          wait_and_trigger_click("Bakteeritauti")
        }.to change(CompletedTask, :count).by(1)

        expect(page).to have_content "Onnittelut! Sait selville, että kyseessä oli Bakteeritauti. Mitä sinun tulee vielä tehdä?"
        expect(page).to have_content 'Toimenpide suoritettu!'
      end

      it "all wrong answers" do
        wait_and_trigger_click("Kurkkukipu")
        wait_and_trigger_click("Virustauti")

        expect {
          wait_and_trigger_click("Bakteeritauti")
        }.to change(CompletedTask, :count).by(1)

        expect(page).to have_content "Onnittelut! Sait selville, että kyseessä oli Bakteeritauti. Mitä sinun tulee vielä tehdä?"
        expect(page).to have_content 'Toimenpide suoritettu!'
      end

    end

    describe "should see the explanations for" do
      it "wrong exercise hypotheses" do
        wait_and_trigger_click("Kurkkukipu")

        expect(page).to have_content "Kurkkukipu ei aiheuta tällaisia oireita!"
        expect(page).to have_content "Kurkkukipu"

        wait_and_trigger_click("Virustauti")

        expect(page).to have_content "Virustauti"
      end

      it "the right exercise hypothesis" do

        wait_and_trigger_click("Bakteeritauti")

        expect(page).to have_content "Bakteeritauti on tosiaan kyseessä!"
      end
    end

    describe "when clicking" do
      describe "the right exercise hypothesis " do
        it "all remaining wrong exercise hypotheses should be checked" do
          expect {
            wait_and_trigger_click("Bakteeritauti")
          }.to change(CheckedHypothesis, :count).by(3)
        end

        it "after wrong exercise hypotheses all should be checked one by one" do
          expect {
            wait_and_trigger_click("Kurkkukipu")
          }.to change(CheckedHypothesis, :count).by(1)

          expect {
            wait_and_trigger_click("Virustauti")
          }.to change(CheckedHypothesis, :count).by(1)

          expect {
            wait_and_trigger_click("Bakteeritauti")
          }.to change(CheckedHypothesis, :count).by(1)
        end
      end

      it "wrong exercise hypotheses they should be checked" do
        expect {
          wait_and_trigger_click("Kurkkukipu")
        }.to change(CheckedHypothesis, :count).by(1)

        expect {
          wait_and_trigger_click("Virustauti")
        }.to change(CheckedHypothesis, :count).by(1)
      end
    end

    describe "after completing conclusion task" do

      before :each do
        wait_and_trigger_click("Bakteeritauti")
        wait_and_trigger_click('Toimenpiteet')
        wait_and_trigger_click(conclusion_task.name)
      end

      it "should be able to view the contents of the conclusion" do

        expect(page).to have_content "Poissuljetut diffit:"
      end

      it "should be able to view the explanation for right conclusion" do
        expect(page).to have_button "Bakteeritauti"
      end

    end
  end

end

