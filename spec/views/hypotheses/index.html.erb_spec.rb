require 'rails_helper'

RSpec.describe "hypotheses/index", :type => :view do
  before(:each) do
    assign(:hypotheses, [
      Hypothesis.create!(
        :name => "Name"
      ),
      Hypothesis.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of hypotheses" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
