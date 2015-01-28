require 'rails_helper'

RSpec.describe "exercises/show", :type => :view do
  before(:each) do
    @exercise = assign(:exercise, Exercise.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end

  it "renders anamnesis when anamnesis is set" do
  	@exercise.anamnesis = "Koiraflunssa"
  	render
  	expect(rendered).to match("Koiraflunssa")
  end
  
  it "renders link to edit exercise when anamnesis is not set" do
  	render
  	expect(rendered).to match("asetettu.</a>")
  end
end
