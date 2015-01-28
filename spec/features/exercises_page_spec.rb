require 'rails_helper'

describe "Exercises page" do

  it "should have right title" do
    visit exercises_path
    expect(page).to have_content 'Exercises'
  end


end