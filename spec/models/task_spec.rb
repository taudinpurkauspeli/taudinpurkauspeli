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

  it "is not saved" do
    expect(task).not_to be_valid
    expect(Task.count).to eq(0)
  end
end

describe "find_highest_level returns 0"  do
  it "when no tasks are created" do
    expect(Task.find_highest_level).to eq(0)
  end
end

describe "find_highest_level returns correct value" do

  let!(:task){FactoryGirl.create(:task)}
  it "when tasks are created" do
    expect(Task.find_highest_level).to eq(1)
  end
end
end