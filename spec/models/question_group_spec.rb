require 'rails_helper'

RSpec.describe QuestionGroup, type: :model do

  it "is not saved without a title" do
    question_group= QuestionGroup.create title:""

    expect(question_group).not_to be_valid
    expect(QuestionGroup.count).to eq(0)

  end

  describe "with correct title" do

    let!(:question_group){FactoryGirl.create(:question_group)}

    it "is saved" do
      expect(question_group).to be_valid
      expect(QuestionGroup.count).to eq(1)
    end
  end

end
