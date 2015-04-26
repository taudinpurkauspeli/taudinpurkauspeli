require 'rails_helper'

describe "Users page", js:true do
  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:exercise2){FactoryGirl.create(:exercise, name: "Kanakuolema")}

  let!(:task){FactoryGirl.create(:task, exercise:exercise)}
  let!(:task2){FactoryGirl.create(:task, name: "Kerää tietoja", exercise:exercise)}
  let!(:task3){FactoryGirl.create(:task, name: "Hoida", exercise:exercise)}
  let!(:task4){FactoryGirl.create(:task, name: "Jatkotoimet", exercise:exercise)}

  let!(:task5){FactoryGirl.create(:task, name: "Hoida", exercise:exercise2)}
  let!(:task6){FactoryGirl.create(:task, name: "Soita läänineläinlääkärille", exercise:exercise2)}

  let!(:teacher){FactoryGirl.create(:user)}
  let!(:student){FactoryGirl.create(:student)}
  let!(:student2){FactoryGirl.create(:student, username: "Seppo", realname: "Seppä", student_number:"000000002")}
  let!(:student3){FactoryGirl.create(:student, username: "Heppo", realname: "Heppä", student_number:"000000003", starting_year:2001)}
  let!(:student4){FactoryGirl.create(:student, username: "Leppo", realname: "Leppä", student_number:"000000004", starting_year:2002)}

  describe "when user is not logged in" do
    before :each do
      visit users_path
    end

    it "he should not be able to visit user index" do
      expect(page).to have_content 'Toiminto vaatii sisäänkirjautumisen'
      expect(current_path).to eq(exercises_path)
    end
  end

  describe "teacher" do

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")
    end

    describe "should be able to" do
      it "visit users page and see all exercises" do
        click_button('Opiskelijoiden seuranta')
        expect(current_path).to eq(users_path)
        expect(page).to have_content 'Opiskelijoiden tiedot'
        expect(page).to have_content 'Lihanautakuolemat'
        expect(page).to have_content 'Kanakuolema'
        expect(page).not_to have_content student.realname
        expect(page).not_to have_content student2.realname
        expect(page).not_to have_content student3.realname
        expect(page).not_to have_content student4.realname
      end

      it "visit list of all students" do
        click_button('Opiskelijoiden seuranta')
        select 'Opiskelijalista', from: 'list_type'
        expect(page).to have_content student.realname
        expect(page).to have_content student2.realname
        expect(page).to have_content student3.realname
        expect(page).to have_content student4.realname

        expect(page).to have_content student.student_number
        expect(page).to have_content student2.student_number
        expect(page).to have_content student3.student_number
        expect(page).to have_content student4.student_number
      end

      it "visit the show page of a student" do
        visit user_path(student)

        expect(current_path).to eq(user_path(student))
        expect(page).to have_content 'Caset:'
        expect(page).to have_content student.realname
        expect(page).to have_content student.student_number
        expect(page).to have_content student.email
        expect(page).to have_content student.starting_year
      end


      describe "when users have started exercises" do
        let!(:completed_task){FactoryGirl.create(:completed_task, task:task, user:student)}
        let!(:completed_task2){FactoryGirl.create(:completed_task, task:task2, user:student)}

        let!(:completed_task3){FactoryGirl.create(:completed_task, task:task5, user:student2)}
        let!(:completed_task4){FactoryGirl.create(:completed_task, task:task6, user:student2)}

        let!(:completed_task5){FactoryGirl.create(:completed_task, task:task, user:student3)}

        it "visit users page and see all users that have started exercises" do
          click_button('Opiskelijoiden seuranta')
          expect(page).to have_content student.realname
          expect(page).to have_content student2.realname
          expect(page).to have_content student3.realname

          expect(page).to have_content '50'
          expect(page).to have_content '100'
          expect(page).to have_content '25'
        end

        describe "in users page" do

          before :each do
            click_button('Opiskelijoiden seuranta')
          end

          it "view users of one exercise" do
            select 'Lihanautakuolemat', from: 'exercise'
            expect(page).to have_content student.realname
            expect(page).to have_content student3.realname
            expect(page).not_to have_content student2.realname
            expect(page).not_to have_content "Kanakuolema"
          end

          it "view users of specific starting year" do
            select 2001, from: 'starting_year'
            expect(page).not_to have_content student.realname
            expect(page).to have_content student3.realname
            expect(page).not_to have_content student2.realname
          end

          it "view users of specific starting year and exercise" do
            select 2000, from: 'starting_year'
            select 'Lihanautakuolemat', from: 'exercise'
            expect(page).to have_content student.realname
            expect(page).not_to have_content student3.realname
            expect(page).not_to have_content student2.realname
          end

        end
      end
    end
  end

  describe "student" do

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")
      expect(page).not_to have_button('Opiskelijoiden seuranta')
    end

    it "should not able to visit student index page" do
      visit users_path
      expect(current_path).to eq(exercises_path)
      expect(page).to have_content('Sinulla ei ole toimintoon vaadittavia käyttöoikeuksia')
    end
  end
end
