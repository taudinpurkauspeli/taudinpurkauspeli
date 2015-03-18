require 'rails_helper'

RSpec.describe Task, :type => :model do
  it "has the name set correctly" do
    task = Task.new name:"Soita asiakkaalle"

    expect(task.name).to eq("Soita asiakkaalle")
  end

  describe "with correct name" do

    let!(:task){FactoryGirl.create(:task)}

    it "is saved" do
      expect(task).to be_valid
      expect(Task.count).to eq(1)
    end
  end

  describe "with incorrect name" do

    let!(:task){Task.create name:""}
    let!(:exercise){FactoryGirl.create(:exercise)}

    it "is not saved" do
      expect(task).not_to be_valid
      expect(Task.count).to eq(0)
    end
  end

  describe "get_highest_level returns 0"  do
    let!(:exercise){FactoryGirl.create(:exercise)}
    it "when no tasks are created" do
      expect(Task.get_highest_level(exercise)).to eq(0)
    end
  end

  describe "get_highest_level returns correct value" do
    let!(:exercise){FactoryGirl.create(:exercise)}

    let!(:task){FactoryGirl.create(:task)}
    it "when tasks are created" do
      expect(Task.get_highest_level(exercise)).to eq(1)
    end
  end

  describe "short_name" do
    let!(:short){FactoryGirl.create(:task_with_long_name)}
    let!(:long){FactoryGirl.create(:task_with_short_name)}

    it "returns full name when it's short" do
      expect(short.short_name).to eq(short.name)
    end

    it "shortens name when it's long" do
      expect(long.short_name).to eq(long.name.split[0...3].join(' ') + ' ...')
    end
  end

  describe "changin task's order" do
    let!(:exercise){FactoryGirl.create(:exercise)}

    def get_values
      actual = Array.new(5)
      i = 0
      Task.all.each do |t|
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