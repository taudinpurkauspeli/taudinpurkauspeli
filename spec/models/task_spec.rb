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

#  describe "moving a task's order up" do
#    let!(:exercise){FactoryGirl.create(:exercise)}
#    describe "changes its level correctly" do
#      it "when it has no siblings" do
#        for i in 1..5 
 #         Task.create name:"Task"+i.to_s, level:i, exercise_id:1
 #       end
  #      task = Task.find_by name:"Task2"
   #     next_task = Task.find_by name:"Task3"
   #     last_task = Task.find_by name:"Task5"
    #    task.move_up
#
 #       Task.all.each do |t|
  #        puts t.level
   #     end
#
 #       expect(last_task.level).to eq(4)
  #      expect(task.level).to eq(1)
  #      expect(next_task.level).to eq(2)
#
 #     end
  #  end
 # end
end