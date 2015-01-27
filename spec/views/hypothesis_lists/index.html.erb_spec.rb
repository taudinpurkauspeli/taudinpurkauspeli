require 'rails_helper'

RSpec.describe "hypothesis_lists/index", :type => :view do
  before(:each) do
    assign(:hypothesis_lists, [
      HypothesisList.create!(
        :hypothesis_id => 1,
        :exercise_id => 2,
        :explanation => "Explanation"
      ),
      HypothesisList.create!(
        :hypothesis_id => 1,
        :exercise_id => 2,
        :explanation => "Explanation"
      )
    ])
  end

  it "renders a list of hypothesis_lists" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Explanation".to_s, :count => 2
  end
end
