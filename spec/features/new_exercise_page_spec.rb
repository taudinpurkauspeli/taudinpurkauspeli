require 'rails_helper'

describe "New Exercise page", js:true do

	describe "teacher" do

		let!(:user){FactoryGirl.create(:user)}

		before :each do
			sign_in(username:"Testipoika", password:"Salainen1")
			wait_and_trigger_click('+ Luo uusi case')
		end

		it "should be able to create a new exercise" do
			fill_in('exercise_name', with: "Broilerimysteeri")

			fill_in_ckeditor 'exercise_anamnesis', with: 'Mitä kanoille on tapahtunut??'

			expect{
				wait_and_trigger_click('Tallenna')
			}.to change(Exercise, :count).by(1)

			expect(page).to have_content 'Broilerimysteeri'
			expect(Exercise.first.name).to eq('Broilerimysteeri')
			expect(Exercise.first.anamnesis).to eq("<p>Mit&auml; kanoille on tapahtunut??</p>\r\n")
		end

		it "should not be able to create a new exercise without a name" do
			fill_in('exercise_name', with: "")
			fill_in_ckeditor 'exercise_anamnesis', with: 'Mitä kanoille on tapahtunut??'

			expect{
				wait_and_trigger_click('Tallenna')
			}.to change(Exercise, :count).by(0)

			expect(current_path).to eq(new_exercise_path)
			expect(page).to have_content 'Casen luominen epäonnistui!'
		end

	end

	describe "student" do
		let!(:user){FactoryGirl.create(:student)}

		before :each do
			sign_in(username:"Opiskelija", password:"Salainen1")
		end

		it "he should not be able to visit new exercise page" do
			visit new_exercise_path
			expect(current_path).to eq(exercises_path)
			expect(page).to have_content('Sinulla ei ole toimintoon vaadittavia käyttöoikeuksia')
		end

	end

end
