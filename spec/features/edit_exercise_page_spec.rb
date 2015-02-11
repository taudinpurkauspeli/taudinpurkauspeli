require 'rails_helper'

describe "Edit Exercise page" do

	describe "if user is signed in as admin" do

		let!(:user){FactoryGirl.create(:user)}
		let!(:exercise){FactoryGirl.create(:exercise)}

		before :each do
			sign_in(username:"Testipoika", password:"Salainen1")
		end


		it "user should be able to edit exercise" do
			visit edit_exercise_path(exercise)

			fill_in('exercise_name', with: "Broilerimysteeri")
			fill_in('exercise_anamnesis', with: "Mitä kanoille on tapahtunut??")

			click_button('Tallenna')

			expect(current_path).to eq(exercise_path(exercise))
			expect(page).to have_content 'Broilerimysteeri'
		end

		it "user should not be able to edit exercise wrong" do
			visit edit_exercise_path(exercise)

			fill_in('exercise_name', with: "")
			fill_in('exercise_anamnesis', with: "Mitä kanoille on tapahtunut??")

			click_button('Tallenna')

			expect(current_path).to eq(exercise_path(exercise))
			expect(page).to have_content 'prohibited'
		end

		


	end

	describe "if user is signed in as normal user" do

		let!(:user){FactoryGirl.create(:user, admin: false)}
		let!(:exercise){FactoryGirl.create(:exercise)}

		before :each do
			sign_in(username:"Testipoika", password:"Salainen1")
		end


		it "user should not be able to visit edit exercise page" do
			visit edit_exercise_path(exercise)

			expect(current_path).to eq(signin_path)
			
		end

		
	end




end
