require 'rails_helper'

RSpec.describe Task, :type => :model do
  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:exercise2){FactoryGirl.create(:exercise, name: "Kanakuolemat")}

  it "has the name set correctly" do
    task = Task.new name:"Soita asiakkaalle"

    expect(task.name).to eq("Soita asiakkaalle")
  end

  describe "with correct name" do

    let!(:task){FactoryGirl.create(:task, exercise:exercise)}

    it "is saved" do
      expect(task).to be_valid
      expect(Task.where(level:1...999).count).to eq(1)
    end

    describe "in exercise" do

      it "cannot be two tasks with same name" do
        expect{
          Task.create name:"Soita asiakkaalle", exercise:exercise
        }.to change(Task, :count).by(0)
      end

    end

    describe "in different exercises" do
      it "can be two tasks with same name" do
        expect{
          Task.create name:"Soita asiakkaalle", exercise:exercise2
        }.to change(Task, :count).by(1)
      end
    end

    describe "as prerequisite task" do
      let!(:hypothesis){FactoryGirl.create(:hypothesis)}
      let!(:hypothesis2){FactoryGirl.create(:hypothesis, name: "Sikatauti")}
      let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, task:task, exercise:exercise, hypothesis:hypothesis)}
      let!(:exercise_hypothesis2){FactoryGirl.create(:exercise_hypothesis, task:task, exercise:exercise, hypothesis:hypothesis2)}

      it "reset_prerequisites resets prerequisites to anamnesis" do
        expect(exercise_hypothesis.task).to eq(task)
        expect(exercise_hypothesis2.task).to eq(task)

        task.reset_prerequisites

        anamnesis = exercise.tasks.first

        expect(ExerciseHypothesis.find(1).task).to eq(anamnesis)
        expect(ExerciseHypothesis.find(2).task).to eq(anamnesis)
      end

    end

  end

  describe "get_highest_level returns 0"  do
    it "when no tasks are created" do
      expect(Task.get_highest_level(exercise)).to eq(0)
    end
  end

  describe "gets completed" do
    let!(:task){FactoryGirl.create(:task, exercise:exercise)}
    let!(:user){FactoryGirl.create(:user)}

    it "if last subtask is done" do
      populate_task(task)
      expect{
        task.subtasks.each do |subtask|
          user.complete_subtask(subtask)
        end
      }.to change{user.completed_tasks.count}.by(1)
    end
  end

  describe "get_highest_level returns correct value" do
    let!(:task){FactoryGirl.create(:task, exercise:exercise)}
    it "when tasks are created" do
      expect(Task.get_highest_level(exercise)).to eq(1)
    end
  end

  describe "short_name" do
    let!(:short){FactoryGirl.create(:task_with_long_name, exercise:exercise)}
    let!(:long){FactoryGirl.create(:task_with_short_name, exercise:exercise)}

    it "returns full name when it's short" do
      expect(short.short_name).to eq(short.name)
    end

    it "shortens name when it's long" do
      expect(long.short_name).to eq(long.name.split[0...3].join(' ') + ' ...')
    end
  end

  describe "changing task's order" do

    def get_values
      actual = Array.new(5)
      i = 0
      Task.where(level:1...999).each do |t|
        actual[i] = t.level
        i += 1
      end
      return actual
    end

    before(:each) do
      for i in 1..5
        Task.create name:"Task"+i.to_s, level:i, exercise_id:1
      end
    end

    describe "by move_up changes its level correctly" do

      it "when it has no siblings" do
        task = Task.find_by name:"Task2"
        task.move_up
        expected = [1, 1, 2, 3, 4]
        actual = get_values
        expect(actual).to match_array(expected)
      end

      it "when it has siblings" do
        task = Task.find_by name:"Task5"
        task.update(level: 3)
        task.move_up
        expected = [1, 2, 3, 4, 5]
        actual = get_values
        expect(actual).to match_array(expected)
      end

      it "when it's top level and has no siblings"  do
        task = Task.find_by name:"Task1"
        task.move_up
        expected = [1, 2, 3, 4, 5]
        actual = get_values
        expect(actual).to match_array(expected)
      end

      it "when it's top level and has siblings"  do
        (Task.find_by name:"Task5").update(level:1)
        task = Task.find_by name:"Task1"
        task.move_up
        expected = [1, 2, 3, 4, 5]
        actual = get_values
        expect(actual).to match_array(expected)
      end
    end


    describe "by move_down changes its level correctly" do

      it "when it has no siblings" do
        task = Task.find_by name:"Task3"
        task.move_down
        expected = [1, 2, 3, 3, 4]
        actual = get_values
        expect(actual).to match_array(expected)
      end

      it "when it has siblings" do
        task = Task.find_by name:"Task5"
        task.update(level: 3)
        task.move_down
        expected = [1, 2, 3, 4, 5]
        actual = get_values
        expect(actual).to match_array(expected)
      end

      it "when it's bottom level and has no siblings"  do
        task = Task.find_by name:"Task5"
        task.move_down
        expected = [1, 2, 3, 4, 5]
        actual = get_values
        expect(actual).to match_array(expected)
      end

      it "when it's bottom level and has siblings"  do
        (Task.find_by name:"Task5").update(level:4)
        task = Task.find_by name:"Task5"
        task.move_up
        expected = [1, 2, 3, 4, 5]
        actual = get_values
        expect(actual).to match_array(expected)
      end
    end
  end
end