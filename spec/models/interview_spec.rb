require 'rails_helper'

RSpec.describe Interview, type: :model do
  it "is not saved without a title" do
    interview = Interview.create title:""

    expect(interview).not_to be_valid
    expect(Interview.count).to eq(0)

  end

  describe "with correct title" do

    let!(:interview){FactoryGirl.create(:interview)}

    it "is saved" do
      expect(interview).to be_valid
      expect(Interview.count).to eq(1)
    end
  end

end
