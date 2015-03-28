
require 'rails_helper'

describe "Task tab spec", js:true do

  let!(:exercise){FactoryGirl.create(:exercise)}

  let!(:task1){FactoryGirl.create(:task, exercise:exercise, level:1)}
  let!(:subtask){FactoryGirl.create(:subtask, task:task1)}
  let!(:task_text){FactoryGirl.create(:task_text, subtask:subtask)}

  let!(:task2){FactoryGirl.create(:task, exercise:exercise, level:1, name: "Ota näyte")}

  describe "student" do

    let!(:user){FactoryGirl.create(:student)}

    before :each do
      sign_in(username:"Opiskelija", password:"Salainen1")

      visit root_path

      click_and_wait('Lihanautakuolemat')
      click_and_wait('Toimenpiteet')
    end

    describe "clicks on an available task" do

      before :each do
        click_and_wait('Soita asiakkaalle')
      end

      it "that task should open as a new tab" do
        expect(page).to have_link 'Soita asiakkaalle'
      end
    end
  end

  describe "teacher" do

    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(username:"Testipoika", password:"Salainen1")

      visit root_path

      click_and_wait('Lihanautakuolemat')
      click_and_wait('Toimenpiteet')
    end

    describe "clicks on a task" do

      before :each do
        click_and_wait('Soita asiakkaalle')
      end

      it "that task should open as a new tab" do
        expect(page).to have_link 'Soita asiakkaalle'
      end
    end
  end
end
