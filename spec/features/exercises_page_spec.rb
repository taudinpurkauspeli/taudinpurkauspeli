require 'rails_helper'

describe "Exercises page", js:true do

  it "should have right title" do
    visit exercises_path
    expect(page).to have_content 'Taudinpurkauspeli'
  end

  it "should have login and signup buttons for a user that hasn't logged in" do 
	visit exercises_path
	expect(page).to have_button('Kirjaudu sisään')
	expect(page).to have_button('Luo uusi tunnus')
  end

  it "user should not be able to login with wrong password" do

    FactoryGirl.create(:user)

    visit exercises_path
    fill_in('username', with:"Testipoika")
    fill_in('password', with:"Väärä salasana")
    click_button('Kirjaudu sisään')

    expect(current_path).to eq(exercises_path)
    expect(page).to have_content "Käyttäjätunnus tai salasana on väärin."

  end

  it "user should not be able to login with wrong username" do

    FactoryGirl.create(:user)

    visit exercises_path
    fill_in('username', with:"Testipoika!")
    fill_in('password', with:"Salainen1")
    click_button('Kirjaudu sisään')

    expect(current_path).to eq(exercises_path)
    expect(page).to have_content "Käyttäjätunnus tai salasana on väärin."

  end



  describe "when exercises exist and admin user is signed in" do

    let!(:exercise){FactoryGirl.create(:exercise)}
    
    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
    end

    it "user should be able to visit exercises page and see exercises" do

      FactoryGirl.create(:exercise, name: "Kanakuolema", anamnesis:"Kuollut kana")
      visit exercises_path

      expect(current_path).to eq(exercises_path)

      expect(page).to have_button 'Lihanautakuolemat'
      expect(page).to have_button 'Kanakuolema'

    end

    it "user should be able to logout" do

      visit exercises_path

      click_button "Kirjaudu ulos"

      expect(current_path).to eq(root_path)

    end

    it "user should be able to delete exercise" do

      visit exercises_path

      click_button "Poista"

      expect(current_path).to eq(exercises_path)

      expect(page).to have_content "Casen poistaminen onnistui!"
      expect(page).not_to have_content "Lihanautakuolemat"

    end


  end

   describe "when exercises exist and normal user is signed in" do

    let!(:exercise){FactoryGirl.create(:exercise)}
    
    let!(:user){FactoryGirl.create(:user, admin: false)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
    end

    it "user should be able to visit exercises page and see exercises" do
      FactoryGirl.create(:exercise, name: "Kanakuolema", anamnesis:"Kuollut kana")

      visit exercises_path

      expect(current_path).to eq(exercises_path)

      expect(page).to have_button 'Lihanautakuolemat'
      expect(page).to have_button 'Kanakuolema'

    end

    it "user should be able to logout" do

      visit exercises_path

      click_button "Kirjaudu ulos"

      expect(current_path).to eq(root_path)

    end

    it "user should not be able to delete exercise" do

      visit exercises_path

      expect(page).not_to have_content "Poista"

    end


  end


end
