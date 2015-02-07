require 'rails_helper'

include HelperMethods

describe "Exercises page" do

  it "should have right title" do
    visit exercises_path
    expect(page).to have_content 'Taudinpurkauspeli'
  end

  it "should have login and signup buttons for a user that hasn't logged in" do 
	visit exercises_path
	expect(page).to have_button('Kirjaudu sisään')
	expect(page).to have_button('Luo uusi tunnus')
  end

  describe "when exercises exist and admin user is signed in" do

    let!(:exercise){FactoryGirl.create(:exercise)}
    let!(:exercise2){FactoryGirl.create(:exercise, name: "Kanakuolema", anamnesis:"Kuollut kana")}
    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
    end

    it "user should be able to visit exercises page and see exercises" do

      visit exercises_path

      expect(current_path).to eq(exercises_path)

      expect(page).to have_button 'Lihanautakuolemat'
      expect(page).to have_button 'Kanakuolema'

    end


  end


end
