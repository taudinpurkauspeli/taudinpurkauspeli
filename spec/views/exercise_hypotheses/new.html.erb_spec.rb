require 'rails_helper'

RSpec.describe "exercise_hypotheses/new", :type => :view do
  before(:each) do
    assign(:exercise_hypothesis, ExerciseHypothesis.new(
      :exercise_id => 1,
      :hypothesis_id => 1,
      :explanation => "MyString"
    ))
  end

  it "renders new exercise_hypothesis form" do
    render

    assert_select "form[action=?][method=?]", exercise_hypotheses_path, "post" do

      assert_select "input#exercise_hypothesis_exercise_id[name=?]", "exercise_hypothesis[exercise_id]"

      assert_select "input#exercise_hypothesis_hypothesis_id[name=?]", "exercise_hypothesis[hypothesis_id]"

      assert_select "input#exercise_hypothesis_explanation[name=?]", "exercise_hypothesis[explanation]"
    end
  end
end
