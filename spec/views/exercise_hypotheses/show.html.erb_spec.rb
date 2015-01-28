require 'rails_helper'

RSpec.describe "exercise_hypotheses/show", :type => :view do
  before(:each) do
    @exercise_hypothesis = assign(:exercise_hypothesis, ExerciseHypothesis.create!(
      :exercise_id => 1,
      :hypothesis_id => 2,
      :explanation => "Explanation"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Explanation/)
  end
end
