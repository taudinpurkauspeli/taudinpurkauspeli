require 'rails_helper'

describe "Task list page", js:true do

  #Exercises
  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:exercise2){FactoryGirl.create(:exercise, name: "Kanakuolemat")}

  #First task with task_text
  let!(:task){FactoryGirl.create(:task, exercise:exercise, level:1)}
  let!(:subtask){FactoryGirl.create(:subtask, task:task)}
  let!(:task_text){FactoryGirl.create(:task_text, subtask:subtask)}

  #Second task with task_text
  let!(:task2_1){FactoryGirl.create(:task, exercise:exercise, name: "Hoida", level: 2)}
  let!(:subtask2){FactoryGirl.create(:subtask, task:task2_1)}
  let!(:task_text2){FactoryGirl.create(:task_text, subtask:subtask2, content:"Lääkäri hoitaa")}

  #Third task with task_text
  let!(:task2_2){FactoryGirl.create(:task, exercise:exercise, name: "Hoida eläintä", level: 2)}
  let!(:task_text3){FactoryGirl.create(:task_text, subtask:subtask3, content:"Lääkäri hoitaa eläintä")}
  let!(:subtask3){FactoryGirl.create(:subtask, task:task2_2)}

  #Fourth task with no subtasks
  let!(:task3){FactoryGirl.create(:task, exercise:exercise2, name: "Soita asiakkaalle uudestaan")}

  #Fifth task with task_text
  let!(:task4){FactoryGirl.create(:task, exercise:exercise, name: "Soita asiakkaalle eläimestä", level: 3)}



  describe "if user is signed in as student" do
    let!(:user){FactoryGirl.create(:student)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")
      visit root_path
    end

    it "he should not be able to view the tasks of an exercise if exercise has not been chosen" do
      visit tasks_path
      expect(current_path).to eq(exercises_path)
      expect(page).to have_content "Valitse ensin case, jota haluat tarkastella!"
    end

    describe "and chooses an exercise" do

      before :each do
        click_button('Lihanautakuolemat')
        click_link('Toimenpiteet')
        wait_for_ajax
      end

      it "user should be able to view the tasks of an exercise" do
        expect(page).to have_button task.name
        expect(page).to have_button task2_1.name
        expect(page).to have_button task2_2.name
        expect(page).to have_button task4.name
        expect(page).not_to have_button task3.name
      end


      it "user should be able to complete the first correct task of an exercise" do
        click_button(task.name)
        wait_for_ajax

        expect {
          click_button('Jatka')
          wait_for_ajax
        }.to change(CompletedTask, :count).by (1)

        expect(current_path).to eq(tasks_path)
        expect(CompletedTask.first.task.name).to eq(task.name)
      end

      it "user should be able to do the tasks of same level in any order (case a)" do

        FactoryGirl.create(:completed_task, task:task, user:user)

        click_button(task2_1.name)
        wait_for_ajax

        click_button('Jatka')
        wait_for_ajax

        click_button(task2_2.name)
        wait_for_ajax

        expect {
          click_button('Jatka')
          wait_for_ajax
        }.to change(CompletedTask, :count).by (1)

        expect(current_path).to eq(tasks_path)
        expect(CompletedTask.last.task.name).to eq(task2_2.name)
      end

      it "user should be able to do the tasks of same level in any order (case b)" do

        FactoryGirl.create(:completed_task, task:task, user:user)

        click_button(task2_2.name)
        wait_for_ajax

        click_button('Jatka')
        wait_for_ajax

        click_button(task2_1.name)
        wait_for_ajax

        expect {
          click_button('Jatka')
          wait_for_ajax
        }.to change(CompletedTask, :count).by (1)

        expect(current_path).to eq(tasks_path)
        expect(CompletedTask.last.task.name).to eq(task2_2.name)
      end

      describe "has not completed required prerequisite tasks" do
        it "user should not be able to complete task" do
          click_button('Hoida')
          wait_for_ajax
          expect(page).to have_content('Et voi vielä suorittaa tätä toimenpidettä.')
        end
      end
    end
  end


  describe "if user is signed in as teacher" do

    # CODE HARD

    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
      visit root_path
      click_button('Lihanautakuolemat')
      click_link('Toimenpiteet')
      wait_for_ajax
    end

    it "he should be able to move task one level up if it has no siblings or children" do
      expect(task4.level).to eq(3)
      expect(task.level).to eq(1)
      expect(task2_1.level).to eq(2)
      expect(task2_2.level).to eq(2)


      click_on("tasks/7/up")
      wait_for_ajax
      expect(Task.last.level).to eq(2)

      expect(Task.where(level:1...9999).first.level).to eq(1)
      expect(Task.find(4).level).to eq(2)
      expect(Task.find(5).level).to eq(2)
    end

    it "he should be able to move task one level up if it has siblings and children" do
      click_on("tasks/7/up")
      wait_for_ajax
      click_on("tasks/7/up")
      wait_for_ajax
      expect(Task.last.level).to eq(2)

      expect(Task.where(level:1...9999).first.level).to eq(1)
      expect(Task.find(4).level).to eq(3)
      expect(Task.find(5).level).to eq(3)
    end

    it "he should be able to move task one level up if it has children but no siblings" do
      click_on("tasks/7/up")
      wait_for_ajax
      click_on("tasks/7/up")
      wait_for_ajax
      click_on("tasks/7/up")
      wait_for_ajax
      expect(Task.last.level).to eq(1)

      expect(Task.where(level:1...9999).first.level).to eq(1)
      expect(Task.find(4).level).to eq(2)
      expect(Task.find(5).level).to eq(2)
    end

    it "he should be able to move task one level down if it has children and siblings" do
      click_on("tasks/7/up")
      wait_for_ajax
      click_on("tasks/7/up")
      wait_for_ajax
      click_on("tasks/7/up")
      wait_for_ajax
      click_on("tasks/7/down")
      wait_for_ajax
      expect(Task.last.level).to eq(2)

      expect(Task.where(level:1...9999).first.level).to eq(1)
      expect(Task.find(4).level).to eq(3)
      expect(Task.find(5).level).to eq(3)
    end

    it "he should be able to move task one level down if it has children and no siblings" do

      click_on("tasks/7/up")
      wait_for_ajax
      click_on("tasks/7/up")
      wait_for_ajax
      click_on("tasks/7/down")
      wait_for_ajax
      expect(Task.last.level).to eq(2)

      expect(Task.where(level:1...9999).first.level).to eq(1)
      expect(Task.find(4).level).to eq(2)
      expect(Task.find(5).level).to eq(2)
    end

    it "he should be able to move task one level down if it has siblings and no children" do

      click_on("tasks/7/up")
      wait_for_ajax
      click_on("tasks/7/down")
      wait_for_ajax
      expect(Task.last.level).to eq(3)

      expect(Task.where(level:1...9999).first.level).to eq(1)
      expect(Task.find(4).level).to eq(2)
      expect(Task.find(5).level).to eq(2)
    end

  end

end
