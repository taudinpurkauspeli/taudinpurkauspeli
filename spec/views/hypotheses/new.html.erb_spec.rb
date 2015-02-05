require 'rails_helper'

RSpec.describe "hypotheses/new", :type => :view do
  before(:each) do
    assign(:hypothesis, Hypothesis.new(
      :name => "Virustauti"
    ))
  end

  it "renders new hypothesis form" do
    render

    assert_select "form[action=?][method=?]", hypotheses_path, "post" do

      assert_select "input#hypothesis_name[name=?]", "hypothesis[name]"
    end
  end
end
