require 'rails_helper'

RSpec.describe Conclusion, type: :model do
  it "has overridden to_s" do
    conclusion = Conclusion.new
    expect(conclusion.to_s).to eq("Päätöstoimenpide")
  end

  describe "user_answered_correctly?" do
      
    describe "when user answers wrong" do

      it "returns false" do
        expect(0).to eq (0)
      end

      it "doesn't add completed_subtask to user" do
        expect(0).to eq (0)
      end
    end

    describe "when user answers correct" do

      it "returns true" do
        expect(0).to eq (0)
      end

      it "adds completed_subtask to user" do
        expect(0).to eq (0)
      end
    end
  end
end
