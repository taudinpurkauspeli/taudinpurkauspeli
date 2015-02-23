require 'rails_helper'

RSpec.describe TaskText, type: :model do
     it "has the content set correctly" do
    task_text = TaskText.new content:"Soita asiakkaalle"

    expect(task_text.content).to eq("Soita asiakkaalle")

  end

  describe "with correct content" do

    let!(:task_text){FactoryGirl.create(:task_text)}

    it "is saved" do
      expect(task_text).to be_valid
      expect(TaskText.count).to eq(1)
    end
  end

  describe "with incorrect content" do

    let!(:task_text){TaskText.create content:""}

    it "is not saved" do
      expect(task_text).not_to be_valid
      expect(TaskText.count).to eq(0)
    end
  end
end
