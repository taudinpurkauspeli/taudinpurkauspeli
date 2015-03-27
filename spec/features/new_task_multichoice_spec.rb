require 'rails_helper'

describe "New Task page", js:true do

  describe "if user is signed in as admin" do

    let!(:user){FactoryGirl.create(:user)}
    let!(:exercise){FactoryGirl.create(:exercise)}

    describe "if multichoice subtasks does not exist" do
      before :each do
        sign_in(username:"Testipoika", password:"Salainen1")

        click_and_wait(exercise.name)

        click_link('Toimenpiteet')

        click_and_wait('+ Luo uusi toimenpide')

        fill_in('task_name', with: "Kysymyksiä asiakkaalle")

        expect{
          click_and_wait('Tallenna')
        }.to change(Task, :count).by(1)

        click_and_wait('+ Luo uusi monivalinta-alitoimenpide')
      end

      it "user should be able to create a new task with a multichoice subtask" do

        fill_in('multichoice_question', with: "Mitä kysyt asiakkaalta:")

        expect{
          click_and_wait('Tallenna kysymys')
        }.to change(Multichoice, :count).by(1)

        expect(page).to have_content 'Kysymys lisättiin onnistuneesti.'
        expect(Subtask.count).to eq(1)
        expect(number_of_ex_tasks).to eq(1)
        expect(Multichoice.first.question).to eq("Mitä kysyt asiakkaalta:")
        expect(Multichoice.first.subtask.task.name).to eq("Kysymyksiä asiakkaalle")
      end


=begin
      it "user should not be able to create a new multichoice subtask without question" do

        fill_in('multichoice_question', with: "")

        expect{
          click_and_wait('Tallenna kysymys')
          wait_for_ajax
        }.to change(Multichoice, :count).by(0)

        expect(page).to have_content 'Seuraavat virheet estivät tallennuksen:'
        expect(number_of_ex_tasks).to eq(1)
        expect(Multichoice.count).to eq(0)
        expect(Subtask.count).to eq(0)
      end
=end

    end
    

    describe "when multichoice subtask already exists" do

      let!(:task){FactoryGirl.create(:task)}
      let!(:subtask){FactoryGirl.create(:subtask)}

      let!(:multichoice){FactoryGirl.create(:multichoice)}

      before :each do
        sign_in(username:"Testipoika", password:"Salainen1")

        click_and_wait(exercise.name)
        click_link('Toimenpiteet')
        click_and_wait(task.name)
        click_and_wait(subtask.to_s)

        expect(page).to have_content 'Muokkaa monivalintakysymystä'
      end

      it "user should be able to update the content of a multichoice subtask" do

        fill_in('multichoice_question', with: "Useita kysymyksiä asiakkaalle:")

        click_and_wait('Tallenna kysymys')

        expect(Multichoice.first.question).to eq("Useita kysymyksiä asiakkaalle:")
      end


=begin
      it "user should not be able to save multichoice edit with invalid name" do

        fill_in('multichoice_question', with: "")

        click_and_wait('Tallenna kysymys')
        wait_for_ajax

        expect(page).to have_content 'Seuraavat virheet estivät tallennuksen:'
        expect(Task.where(name:"Kysymyksiä asiakkaalle").count).to eq(1)
      end
=end
    end
  end
end