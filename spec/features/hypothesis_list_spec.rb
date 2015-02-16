require 'rails_helper'

describe "Hypothesis list page" do

  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:hypothesis){FactoryGirl.create(:hypothesis)}
  let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis)}
  let!(:hypothesis_group){FactoryGirl.create(:hypothesis_group)}

	describe "if user is signed in as student" do

		let!(:user){FactoryGirl.create(:student)}

    before :each do
     sign_in(username:"Opiskelija", password:"Salainen1")

     visit root_path

     click_button('Lihanautakuolemat')
     click_link('Työhypoteesit')
   end

   it "user should be able to view the hypotheses of an exercise" do
      expect(page).to have_button 'Bakteeritaudit'
      expect(page).to have_button 'Virustauti'
    end

    it "user should be able check hypotheses of an exercise" do
      click_button('Virustauti')
      expect(CheckedHypothesis.count).to eq(1)
    end
  end
end
