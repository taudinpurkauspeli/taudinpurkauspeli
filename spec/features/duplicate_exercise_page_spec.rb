require 'rails_helper'

describe "Duplicate exercise page" do

  let!(:exercise){FactoryGirl.create(:exercise)}

  let!(:teacher){FactoryGirl.create(:user)}
  let!(:student){FactoryGirl.create(:student)}

  describe "teacher" do

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
    end


    it "should be able to duplicate an exercise" do
      expect {
        first(:button, "Kopioi").click
      }.to change(Exercise, :count).by(1)

      expect(current_path).to eq(exercises_path)

      expect(page).to have_content "Casen kopioiminen onnistui!"
      expect(Exercise.where(name:"Lihanautakuolemat").count).to eq(2)
    end

  end

  describe "student" do

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")
    end

    it "should not be able to duplicate exercise" do
      expect(page).not_to have_button "Kopioi"
    end

  end
end
