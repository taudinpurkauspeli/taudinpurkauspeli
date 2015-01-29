require 'rails_helper'

describe "New Exercise page" do

  it "user should be able to create a new exercise" do 
  	visit new_exercise_path

  	fill_in('exercise_name', with: "Broilerimysteeri")
  	fill_in('exercise_anamnesis', with: "Mitä kanoille on tapahtunut??")

  	click_button('Tallenna')

  	expect(page).to have_content 'Broilerimysteeri'
  end


end