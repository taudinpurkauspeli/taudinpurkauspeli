require 'rails_helper'

RSpec.describe "exercises/index", :type => :view do
  before(:each) do
    assign(:exercises, [
      Exercise.create!(
        :name => "Name"
      ),
      Exercise.create!(
        :name => "Name2"
      )
    ])
  end

  it "renders a list of exercises" do
    render
    assert_select ".btn-exercise", :count => 2
  end
end
