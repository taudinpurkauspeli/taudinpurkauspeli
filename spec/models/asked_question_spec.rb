require 'rails_helper'

RSpec.describe AskedQuestion, type: :model do
  it "is not saved without user id" do
    asked_question = AskedQuestion.create user_id:nil, question_id: 1

    expect(asked_question).not_to be_valid
    expect(AskedQuestion.count).to eq(0)
  end

  it "is not saved without question id" do
    asked_question = AskedQuestion.create user_id:1, question_id: nil

    expect(asked_question).not_to be_valid
    expect(AskedQuestion.count).to eq(0)
  end

  describe "with correct user id and question id" do

    it "is saved" do
      asked_question = AskedQuestion.new(user_id: 123, question_id: 321)
      expect(asked_question).to be_valid
      asked_question.save
      expect(AskedQuestion.count).to eq(1)
    end
  end

end
