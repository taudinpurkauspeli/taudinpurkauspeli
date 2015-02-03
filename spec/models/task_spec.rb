require 'rails_helper'

RSpec.describe Task, :type => :model do
   it "has the name set correctly" do
    task = Hypothesis.new name:"Soita asiakkaalle"

    expect(hypothesis.name).to eq("Soita asiakkaalle")

  end

  describe "with correct name" do

    let!(:task){FactoryGirl.create(:task)}

    it "is saved" do
      expect(task).to be_valid
      expect(Task.count).to eq(1)
    end
  end

end
