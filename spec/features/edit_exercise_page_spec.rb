require 'rails_helper'

describe "Edit Exercise page", js:true do

	let!(:exercise){FactoryGirl.create(:exercise)}

	describe "teacher" do

		let!(:user){FactoryGirl.create(:user)}

		before :each do
			sign_in(username:"Testipoika", password:"Salainen1")

			wait_and_trigger_click(exercise.name)
			wait_and_trigger_click('Muokkaa')
		end

		it "should be able to edit exercise" do

			fill_in('exercise_name', with: "Broilerimysteeri")
			fill_in_ckeditor 'exercise_anamnesis', with: 'Mitä kanoille on tapahtunut??'

			wait_and_trigger_click('Tallenna')

			expect(current_path).to eq(exercise_path(exercise))
			expect(page).to have_content 'Broilerimysteeri'
			expect(Exercise.first.name).to eq('Broilerimysteeri')
			expect(Exercise.first.anamnesis).to eq("<p>Mit&auml; kanoille on tapahtunut??</p>\r\n")
		end

		it "should not be able to edit exercise wrong" do

			fill_in('exercise_name', with: "")
			fill_in_ckeditor 'exercise_anamnesis', with: 'Mitä kanoille on tapahtunut??'

			wait_and_trigger_click('Tallenna')

			expect(current_path).to eq(exercise_path(exercise))
		end

	end

	describe "student" do

		let!(:user){FactoryGirl.create(:student)}

		before :each do
			sign_in(username:"Opiskelija", password:"Salainen1")
		end

		it "should not be able to visit edit exercise page" do
			visit edit_exercise_path(exercise)

			expect(page).to have_content 'Sinulla ei ole toimintoon vaadittavia käyttöoikeuksia'
		end

	end

end


