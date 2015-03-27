=begin
require 'rails_helper'

describe "Task list page", js:true do

  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:task1){FactoryGirl.create(:task, exercise:exercise, level:1)}
  let!(:subtask){FactoryGirl.create(:subtask, task:task1)}
  let!(:task_text){FactoryGirl.create(:task_text, subtask:subtask)}
  let!(:task2){FactoryGirl.create(:task, exercise:exercise, level:1, name: "Ota näyte")}

  describe "if user is signed in as student" do

    let!(:user){FactoryGirl.create(:student)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      visit root_path

      click_button('Lihanautakuolemat')
      click_link('Toimenpiteet')
    end

    it "user should be able to view the tasks of an exercise" do
      expect(page).to have_button 'Soita asiakkaalle'
      expect(page).to have_button 'Ota näyte'
    end

    describe "and clicks on an available task" do

      before :each do
        click_button('Soita asiakkaalle')
      end

      it "that task should open as a new tab" do
        expect(page).to have_link 'Soita asiakkaalle'
      end

      describe "user is able to complete that task" do

        it "and a completed_task is added to the database" do
          expect {
            first(:button, 'Jatka').click
            }.to change(CompletedTask, :count).by(1)
          end
        end
      end
    end

    describe "if user is signed in as teacher" do

      let!(:user){FactoryGirl.create(:user)}

      before :each do
        sign_in(username:"Testipoika", password:"Salainen1")

        visit root_path

        click_button('Lihanautakuolemat')
        click_link('Toimenpiteet')
      end

      it "user should be able to view the tasks of an exercise" do
        expect(page).to have_button 'Soita asiakkaalle'
        expect(page).to have_button 'Ota näyte'
      end

      describe "and clicks on a task" do

        before :each do
          click_button('Soita asiakkaalle')
        end

        it "that task should not open as a new tab" do
          expect(page).not_to have_link 'Soita asiakkaalle'
        end
      end
    end
  end
=end
