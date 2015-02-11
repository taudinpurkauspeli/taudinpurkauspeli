require 'rails_helper'

describe "New Exercise page" do

	describe "if user is signed in as admin" do

		let!(:user){FactoryGirl.create(:user)}

		before :each do
			sign_in(username:"Testipoika", password:"Salainen1")
		end


		it "user should be able to create a new exercise" do
			visit new_exercise_path

			fill_in('exercise_name', with: "Broilerimysteeri")
			fill_in('exercise_anamnesis', with: "Mitä kanoille on tapahtunut??")

			click_button('Tallenna')
			
			expect(page).to have_content 'Casen luominen onnistui!'
			expect(page).to have_content 'Broilerimysteeri'
		end

		it "user should not be able to create a new exercise wrong" do
			visit new_exercise_path

			fill_in('exercise_name', with: "")
			fill_in('exercise_anamnesis', with: "Mitä kanoille on tapahtunut??")

			click_button('Tallenna')
			
			expect(current_path).to eq(exercises_path)
			expect(page).to have_content 'prohibited'
		end


		


	end

	describe "if user is signed in as normal user" do

		let!(:user){FactoryGirl.create(:user, admin: false)}
		

		before :each do
			sign_in(username:"Testipoika", password:"Salainen1")
		end


		it "user should not be able to visit new exercise page" do
			visit new_exercise_path

			expect(current_path).to eq(signin_path)
			
		end

		
	end




end
