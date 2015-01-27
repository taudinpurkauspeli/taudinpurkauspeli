require 'rails_helper'

RSpec.describe "exercise_hypotheses/edit", :type => :view do
  before(:each) do
    @exercise_hypothesis = assign(:exercise_hypothesis, ExerciseHypothesis.create!(
      :exercise_id => 1,
      :hypothesis_id => 1,
      :explanation => "MyString"
    ))
  end

  it "renders the edit exercise_hypothesis form" do
    render

    assert_select "form[action=?][method=?]", exercise_hypothesis_path(@exercise_hypothesis), "post" do

      assert_select "input#exercise_hypothesis_exercise_id[name=?]", "exercise_hypothesis[exercise_id]"

      assert_select "input#exercise_hypothesis_hypothesis_id[name=?]", "exercise_hypothesis[hypothesis_id]"

      assert_select "input#exercise_hypothesis_explanation[name=?]", "exercise_hypothesis[explanation]"
    end
  end
end
