require 'rails_helper'

describe "Task list page" do

  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:task1){FactoryGirl.create(:task)}
  let!(:task2){FactoryGirl.create(:sample)}

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

    describe "and clicks on an enabled task" do
      
      before :each do
        click_button('Soita asiakkaalle')
      end

      it "that task should open as a new tab" do
        expect(page).to have_link 'Soita asiakkaalle'
      end
    end
  end
end