require 'rails_helper'

describe "User show page", js:true do
  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:exercise2){FactoryGirl.create(:exercise, name: "Kanakuolema")}
  let!(:exercise3){FactoryGirl.create(:exercise, name: "Hevossairaus")}

  let!(:task){FactoryGirl.create(:task, exercise:exercise)}
  let!(:task2){FactoryGirl.create(:task, name: "Kerää tietoja", exercise:exercise)}
  let!(:task3){FactoryGirl.create(:task, name: "Hoida", exercise:exercise)}
  let!(:task4){FactoryGirl.create(:task, name: "Jatkotoimet", exercise:exercise)}

  let!(:task5){FactoryGirl.create(:task, name: "Hoida", exercise:exercise2)}
  let!(:task6){FactoryGirl.create(:task, name: "Soita läänineläinlääkärille", exercise:exercise2)}

  let!(:student){FactoryGirl.create(:student)}
  let!(:student2){FactoryGirl.create(:student, username: "Seppo", realname: "Seppä", student_number:"000000002")}

  describe "student" do

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")
      expect(page).not_to have_button('Opiskelijoiden seuranta')
      visit user_path(student)
    end

    describe "should be able to" do
      it "visit own show page" do
        expect(current_path).to eq(user_path(student))
        expect(page).to have_content 'Caset:'
        expect(page).to have_content 'Ei aloitettuja caseja!'
        expect(page).to have_content student.realname
        expect(page).to have_content student.student_number
        expect(page).to have_content student.email
        expect(page).to have_content student.starting_year
      end

      describe "change" do
        before :each do
          click_and_wait 'Muokkaa tietoja'
        end

        it "password" do
          fill_in 'user_password', with: 'Salaisuus'
          fill_in 'user_password_confirmation', with: 'Salaisuus'
          click_and_wait 'Päivitä salasana'
          expect(page).to have_content 'Käyttäjän tiedot päivitetty'

          updated_student = User.where(username:"Opiskelija").first
          expect(updated_student.realname).to eq(student.realname)
          expect(updated_student.username).to eq(student.username)
          expect(updated_student.email).to eq(student.email)
          expect(updated_student.student_number).to eq(student.student_number)
          expect(updated_student.starting_year).to eq(student.starting_year)

          click_and_wait 'Kirjaudu ulos'
          sign_in(username:"Opiskelija", password:"Salaisuus")
          expect(page).to have_content 'Tervetuloa takaisin!'
        end

        it "other information without changing password" do
          fill_in 'user_realname', with: 'Uusi hassu nimi'
          fill_in 'user_email', with: 'uusi@nimi.com'
          click_and_wait 'Päivitä'
          expect(page).to have_content 'Käyttäjän tiedot päivitetty'

          updated_student = User.where(username:"Opiskelija").first
          expect(updated_student.realname).to eq('Uusi hassu nimi')
          expect(updated_student.username).to eq(student.username)
          expect(updated_student.email).to eq('uusi@nimi.com')
          expect(updated_student.student_number).to eq(student.student_number)
          expect(updated_student.starting_year).to eq(student.starting_year)

          click_and_wait 'Kirjaudu ulos'
          sign_in(username:"Opiskelija", password:"Salainen1")
          expect(page).to have_content 'Tervetuloa takaisin!'
        end

      end

      describe "when he has started exercises" do
        let!(:completed_task){FactoryGirl.create(:completed_task, task:task, user:student)}
        let!(:completed_task2){FactoryGirl.create(:completed_task, task:task2, user:student)}

        let!(:completed_task3){FactoryGirl.create(:completed_task, task:task5, user:student)}
        let!(:completed_task4){FactoryGirl.create(:completed_task, task:task6, user:student)}

        it "visit show page and see started exercises" do
          visit user_path(student)
          expect(page).to have_content exercise.name
          expect(page).to have_content exercise2.name
          expect(page).not_to have_content exercise3.name

          expect(page).to have_content '50'
          expect(page).to have_content '100'
        end

      end
    end

    describe "should not be able to" do
      it "visit show page of another student" do
        visit user_path(student2)
        expect(current_path).to eq(exercises_path)
        expect(page).to have_content('Pääsy toisen käyttäjän tietoihin estetty!')
      end

      it "update information wrong" do
        click_and_wait 'Muokkaa tietoja'
        fill_in 'user_realname', with: ''
        click_and_wait 'Päivitä'
        expect(page).to have_content 'Seuraavat virheet estivät tallennuksen:'
      end
    end
  end

end
