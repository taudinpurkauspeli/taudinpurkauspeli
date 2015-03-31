require 'rails_helper'

RSpec.describe Question, type: :model do

  it "is not saved without a title" do
    question = Question.create title:""

    expect(question).not_to be_valid
    expect(Question.count).to eq(0)

  end


  it "is not saved without content" do
    question = Question.create content:""

    expect(question).not_to be_valid
    expect(Question.count).to eq(0)

  end

  describe "with correct title" do

    let!(:question){FactoryGirl.create(:question)}

    it "is saved" do
      expect(question).to be_valid
      expect(Question.count).to eq(1)
    end

    it "cannot create another with same title" do
      question2 = Question.create title: "Oliko lehmällä veljiä?"
      expect(question2).not_to be_valid
      expect(Question.count).to eq(1)
    end
  end

end
