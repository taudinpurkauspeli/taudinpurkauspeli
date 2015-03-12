require 'rails_helper'

describe "Task list page" do

  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:exercise2){FactoryGirl.create(:exercise, name: "Kanakuolemat")}
  let!(:task){FactoryGirl.create(:task)}
  let!(:task2_1){FactoryGirl.create(:task, name: "Hoida", level: 2)}
  let!(:task2_2){FactoryGirl.create(:task, name: "Hoida eläintä", level: 2)}
  let!(:task3){FactoryGirl.create(:task, exercise_id: 2, name: "Soita asiakkaalle uudestaan")}

  describe "if user is signed in as student" do
    let!(:user){FactoryGirl.create(:student)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")
      visit root_path
    end

    it "user should not be able to view the tasks of an exercise if no exercise has been chosen" do
      visit tasks_path
      expect(current_path).to eq(exercises_path)
      expect(page).to have_content("Valitse ensin case, jota haluat tarkastella!")
    end

    describe "and chooses an exercise" do

      before :each do
        click_button('Lihanautakuolemat')
        click_link('Toimenpiteet')
      end

      it "user should be able to view the tasks of an exercise" do
        expect(page).to have_button 'Soita asiakkaalle'
        expect(page).to have_button 'Hoida'
        expect(page).not_to have_button 'Soita asiakkaalle uudestaan'
      end

      it "user should be able to complete the first correct task of an exercise" do
        click_button(task.name)
        expect {
          click_button('Jatka')
        }.to change(CompletedTask, :count).by (1)
        expect(current_path).to eq(tasks_path)
      end


      it "user should be able to do the tasks of same level in any order (case a)" do
        FactoryGirl.create(:completed_task)
        click_button(task2_1.name)
        click_button('Jatka')
        click_button(task2_2.name)
        expect {
          click_button('Jatka')
        }.to change(CompletedTask, :count).by (1)
        expect(current_path).to eq(tasks_path)
      end

      it "user should be able to do the tasks of same level in any order (case b)" do
        FactoryGirl.create(:completed_task)
        click_button(task2_2.name)
        click_button('Jatka')
        click_button(task2_1.name)
        expect {
          click_button('Jatka')
        }.to change(CompletedTask, :count).by (1)
        expect(current_path).to eq(tasks_path)
      end

      describe "has not completed required prerequisite tasks" do
        it "user should not be able to complete task" do
          click_button('Hoida')
          expect(page).to have_content('Et voi vielä suorittaa tätä toimenpidettä.')
        end
      end
    end
  end
end
