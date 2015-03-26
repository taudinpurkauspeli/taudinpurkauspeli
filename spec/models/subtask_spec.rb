require 'rails_helper'

RSpec.describe Subtask, type: :model do
	it "has the ids set correctly" do
     subtask = Subtask.new task_id: 1

    expect(subtask.task_id).to eq(1)

  end

  describe "with correct ids" do
    let!(:task){FactoryGirl.create(:task, exercise_id:1, level:1)}
    let!(:subtask){FactoryGirl.create(:subtask, task_id:1)}

    it "is saved" do
      expect(subtask).to be_valid
      expect(Subtask.count).to eq(1)
    end
  end

  describe "with incorrect id" do

    it "is not saved" do
      subtask = Subtask.create task_id: nil
      expect(subtask).not_to be_valid
      expect(Subtask.count).to eq(0)
    end
  end

  describe "level" do
    let!(:task){FactoryGirl.create(:task, exercise_id:1, level:1)}

    it "is set correctly when no subtasks exist" do
      subtask = Subtask.create task_id:task.id
      expect(subtask.level).to eq(1)
    end

    it "is set correctly when prior subtasks exist" do
      for i in 0...3
        Subtask.create task_id:task.id
      end
      subtask = Subtask.create task_id:task.id
      expect(subtask.level).to eq(4)
    end

    it "sorts subtasks correctly" do
      actual = Array.new(5)
      for i in 0...5
        actual[i] = Subtask.create task_id:task. id
      end
      actual[1].update(level:5)
      actual[4].update(level:2)

      actual = task.subtasks.map(&:level)
      expected = [1, 2, 3, 4, 5]

      expect(actual).to eq expected
    end
  end
end
