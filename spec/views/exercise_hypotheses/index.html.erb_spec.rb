require 'rails_helper'

RSpec.describe "exercise_hypotheses/index", :type => :view do
  before(:each) do
    assign(:exercise_hypotheses, [
      ExerciseHypothesis.create!(
        :exercise_id => 1,
        :hypothesis_id => 2,
        :explanation => "Explanation"
      ),
      ExerciseHypothesis.create!(
        :exercise_id => 1,
        :hypothesis_id => 2,
        :explanation => "Explanation"
      )
    ])
  end

  it "renders a list of exercise_hypotheses" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Explanation".to_s, :count => 2
  end
end
