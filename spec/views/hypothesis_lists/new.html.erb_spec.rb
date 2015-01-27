require 'rails_helper'

RSpec.describe "hypothesis_lists/new", :type => :view do
  before(:each) do
    assign(:hypothesis_list, HypothesisList.new(
      :hypothesis_id => 1,
      :exercise_id => 1,
      :explanation => "MyString"
    ))
  end

  it "renders new hypothesis_list form" do
    render

    assert_select "form[action=?][method=?]", hypothesis_lists_path, "post" do

      assert_select "input#hypothesis_list_hypothesis_id[name=?]", "hypothesis_list[hypothesis_id]"

      assert_select "input#hypothesis_list_exercise_id[name=?]", "hypothesis_list[exercise_id]"

      assert_select "input#hypothesis_list_explanation[name=?]", "hypothesis_list[explanation]"
    end
  end
end
