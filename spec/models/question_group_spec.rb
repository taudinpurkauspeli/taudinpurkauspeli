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

  describe "delete_unused_groups" do
    let!(:empty_group){FactoryGirl.create(:question_group, title:"Empty")}
    let!(:populated_group){FactoryGirl.create(:question_group, title:"Full")}
    let!(:question){FactoryGirl.create(:question, question_group:populated_group)}

    it "deletes empty groups" do
      expect {
        QuestionGroup.delete_unused_groups
      }.to change{QuestionGroup.all.count}.by(-1)
    end

    it "doesn't delete populated groups" do
      QuestionGroup.delete_unused_groups
      expect(QuestionGroup.find_by title:"Full" ).not_to be_nil
    end
  end

end
