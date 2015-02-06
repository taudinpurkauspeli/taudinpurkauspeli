require 'rails_helper'

describe "Exercises page" do

  it "should have right title" do
    visit exercises_path
    expect(page).to have_content 'Taudinpurkauspeli'
  end

  it "should have login and signup buttons for a user that hasn't logged in" do 
	visit exercises_path
	expect(page).should have_button('Kirjaudu sisään')
	expect(page).should have_button('Luo uusi tunnus')
  end


end
