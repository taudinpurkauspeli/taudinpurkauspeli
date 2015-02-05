require 'rails_helper'

RSpec.describe "exercise_hypotheses/index", :type => :view do
  before(:each) do
    assign(:exercise_hypotheses, [
      ExerciseHypothesis.create!(
        :exercise_id => 1,
        :hypothesis_id => 2,
        :explanation => "Oikea Valinta!"
      ),
      ExerciseHypothesis.create!(
        :exercise_id => 1,
        :hypothesis_id => 2,
        :explanation => "Oikea Valinta!"
      )
    ])
  end

  it "renders a list of exercise_hypotheses" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Oikea Valinta!".to_s, :count => 2
  end
end
