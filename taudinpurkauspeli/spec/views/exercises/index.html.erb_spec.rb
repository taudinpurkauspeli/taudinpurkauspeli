require 'rails_helper'

RSpec.describe "exercises/index", :type => :view do
  before(:each) do
    assign(:exercises, [
      Exercise.create!(
        :name => "Name"
      ),
      Exercise.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of exercises" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
