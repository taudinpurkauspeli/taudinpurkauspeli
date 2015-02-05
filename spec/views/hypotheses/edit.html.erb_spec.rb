require 'rails_helper'

RSpec.describe "hypotheses/edit", :type => :view do
  before(:each) do
    @hypothesis = assign(:hypothesis, Hypothesis.create!(
      :name => "Virustauti"
    ))
  end

  it "renders the edit hypothesis form" do
    render

    assert_select "form[action=?][method=?]", hypothesis_path(@hypothesis), "post" do

      assert_select "input#hypothesis_name[name=?]", "hypothesis[name]"
    end
  end
end
