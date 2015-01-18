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
end
