require 'rails_helper'

RSpec.describe Subtask, type: :model do
	it "has the ids set correctly" do
     subtask = Subtask.new task_id: 1, task_text_id: 1

    expect(subtask.task_id).to eq(1)
    expect(subtask.task_text_id).to eq(1)

  end

  describe "with correct ids" do

    let!(:subtask){FactoryGirl.create(:subtask)}

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
end
