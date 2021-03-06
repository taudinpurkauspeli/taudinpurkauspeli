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
  let!(:subtask3){FactoryGirl.create(:subtask, task:task2_2)}
  let!(:task_text3){FactoryGirl.create(:task_text, subtask:subtask3, content:"Lääkäri hoitaa eläintä")}

  #Fourth task with no subtasks
  let!(:task3){FactoryGirl.create(:task, exercise:exercise2, name: "Soita asiakkaalle uudestaan")}

  #Fifth task with task_text
  let!(:task4){FactoryGirl.create(:task, exercise:exercise, name: "Soita asiakkaalle eläimestä", level: 3)}

  describe "student" do
    let!(:user){FactoryGirl.create(:student)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")
      visit exercises_path
    end

    it "should not be able to view tasks of an unchosen exercise" do
      visit tasks_path
      expect(current_path).to eq(exercises_path)
      expect(page).to have_content "Valitse ensin case, jota haluat tarkastella!"
    end

    describe "has chosen an exercise" do

      before :each do
        wait_and_trigger_click('Lihanautakuolemat')
        wait_and_trigger_click('Toimenpiteet')
      end

      describe "then he should be able to" do

        it "view the tasks of an exercise" do
          expect(page).to have_button task.name
          expect(page).to have_button task2_1.name
          expect(page).to have_button task2_2.name
          expect(page).to have_button task4.name
          expect(page).not_to have_button task3.name
        end

        it "complete the first correct task of an exercise" do
          wait_and_trigger_click(task.name)

          expect {
            wait_and_trigger_click('Jatka')
          }.to change(CompletedTask, :count).by (1)

          expect(CompletedTask.first.task.name).to eq(task.name)
        end

        it "do the tasks of same level in any order (case a)" do
          FactoryGirl.create(:completed_task, task:task, user:user)

          wait_and_trigger_click(task2_1.name)

          wait_and_trigger_click('Jatka')
          wait_and_trigger_click('Toimenpiteet')
          wait_and_trigger_click(task2_2.name)

          expect {
            wait_and_trigger_click('Jatka')
          }.to change(CompletedTask, :count).by (1)

          expect(CompletedTask.count).to eq(3)
        end

        it "do the tasks of same level in any order (case b)" do
          FactoryGirl.create(:completed_task, task:task, user:user)

          wait_and_trigger_click(task2_2.name)

          wait_and_trigger_click('Jatka')
          wait_and_trigger_click('Toimenpiteet')
          wait_and_trigger_click(task2_1.name)

          expect {
            wait_and_trigger_click('Jatka')
          }.to change(CompletedTask, :count).by (1)

          expect(CompletedTask.count).to eq(3)
        end

      end

      describe "but has not completed required prerequisite tasks" do
        it "he should not be able to complete task" do
          wait_and_trigger_click('Hoida')
          expect(page).to have_content('Et voi vielä suorittaa tätä toimenpidettä, vaan sinun tulee suorittaa ainakin yksi muu toimenpide ennen tätä.')
        end
      end
    end
  end

  describe "teacher" do

    # CODE HARD

    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
      visit exercises_path
      wait_and_trigger_click('Lihanautakuolemat')
      wait_and_trigger_click('Toimenpiteet')
    end

    it "should be able to view the tasks of an exercise" do
      expect(page).to have_button task.name
      expect(page).to have_button task2_1.name
      expect(page).to have_button task2_2.name
      expect(page).to have_button task4.name
      expect(page).not_to have_button task3.name
    end

    describe "should be able to move task one level" do

      describe "up if it has" do
        it "siblings or children" do
          expect(task4.level).to eq(3)
          expect(task.level).to eq(1)
          expect(task2_1.level).to eq(2)
          expect(task2_2.level).to eq(2)

          wait_and_trigger_click("tasks/7/up")
          expect(Task.last.level).to eq(2)

          expect(Task.where(level:1...9999).first.level).to eq(1)
          expect(Task.find(4).level).to eq(2)
          expect(Task.find(5).level).to eq(2)
        end

        it "siblings and children" do
          wait_and_trigger_click("tasks/7/up")
          wait_and_trigger_click("tasks/7/up")
          expect(Task.last.level).to eq(2)

          expect(Task.where(level:1...9999).first.level).to eq(1)
          expect(Task.find(4).level).to eq(3)
          expect(Task.find(5).level).to eq(3)
        end

        it "children but no siblings" do
          wait_and_trigger_click("tasks/7/up")
          wait_and_trigger_click("tasks/7/up")
          wait_and_trigger_click("tasks/7/up")
          expect(Task.last.level).to eq(1)

          expect(Task.where(level:1...9999).first.level).to eq(1)
          expect(Task.find(4).level).to eq(2)
          expect(Task.find(5).level).to eq(2)
        end
      end

      describe "down if it has" do
        it "children and siblings" do
          wait_and_trigger_click("tasks/7/up")
          wait_and_trigger_click("tasks/7/up")
          wait_and_trigger_click("tasks/7/up")
          wait_and_trigger_click("tasks/7/down")

          expect(Task.last.level).to eq(2)

          expect(Task.where(level:1...9999).first.level).to eq(1)
          expect(Task.find(4).level).to eq(3)
          expect(Task.find(5).level).to eq(3)
        end

        it "children and no siblings" do

          wait_and_trigger_click("tasks/7/up")
          wait_and_trigger_click("tasks/7/up")
          wait_and_trigger_click("tasks/7/down")
          expect(Task.last.level).to eq(2)

          expect(Task.where(level:1...9999).first.level).to eq(1)
          expect(Task.find(4).level).to eq(2)
          expect(Task.find(5).level).to eq(2)
        end


        it "siblings and no children" do

          wait_and_trigger_click("tasks/7/up")
          wait_and_trigger_click("tasks/7/down")
          expect(Task.last.level).to eq(3)

          expect(Task.where(level:1...9999).first.level).to eq(1)
          expect(Task.find(4).level).to eq(2)
          expect(Task.find(5).level).to eq(2)
        end
      end

    end
  end

end
