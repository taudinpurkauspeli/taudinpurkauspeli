require 'rails_helper'

describe "Exercises page", js:true do

  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:exercise2){FactoryGirl.create(:exercise, name: "Kanakuolema", anamnesis:"Kuollut kana")}

  let!(:teacher){FactoryGirl.create(:user)}
  let!(:student){FactoryGirl.create(:student)}

  describe "when user is not logged in" do
    before :each do
      visit exercises_path
    end

    it "page should have right title" do
      expect(page).to have_content 'Taudinpurkauspeli'
    end

    it "page should have login and signup buttons" do
      expect(page).to have_button('Kirjaudu sisään')
      expect(page).to have_button('Luo uusi tunnus')
    end

    describe "he should not be able to login with wrong" do


      it "password" do

        fill_in('username', with:"Testipoika")
        fill_in('password', with:"Väärä salasana")
        wait_and_trigger_click('Kirjaudu sisään')

        expect(current_path).to eq(exercises_path)
        expect(page).to have_content "Käyttäjätunnus tai salasana on väärin."

      end

      it "username" do

        fill_in('username', with:"Testipoika!")
        fill_in('password', with:"Salainen1")
        wait_and_trigger_click('Kirjaudu sisään')

        expect(current_path).to eq(exercises_path)
        expect(page).to have_content "Käyttäjätunnus tai salasana on väärin."

      end
    end

  end

  describe "teacher" do

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
    end

    it "should be able to visit exercises page and see exercises" do

      expect(current_path).to eq(exercises_path)

      expect(page).to have_button 'Lihanautakuolemat'
      expect(page).to have_button 'Kanakuolema'
    end

    it "should be able to logout" do
      wait_and_trigger_click "Kirjaudu ulos"

      expect(current_path).to eq(exercises_path)
    end

    it "should be able to delete an exercise" do
      expect {
        first(:button, "Poista").click
        wait_for_ajax
      }.to change(Exercise, :count).by(-1)

      expect(current_path).to eq(exercises_path)

      expect(page).to have_content "Casen poistaminen onnistui!"
      expect(page).not_to have_content "Lihanautakuolemat"
    end

  end

  describe "student" do

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")
    end

    it "should be able to visit exercises page and see exercises" do
      expect(current_path).to eq(exercises_path)

      expect(page).to have_button 'Lihanautakuolemat'
      expect(page).to have_button 'Kanakuolema'
    end

    it "should be able to logout" do
      wait_and_trigger_click "Kirjaudu ulos"
      expect(current_path).to eq(exercises_path)
    end

    it "should not be able to delete exercise" do
      expect(page).not_to have_content "Poista"
    end

  end
end
