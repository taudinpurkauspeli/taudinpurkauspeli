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
    assert_select "btn-exercise", :text => "Name".to_s, :count => 1
    assert_select "btn-exercise", :text => "Name2".to_s, :count => 1
  end
end
