require 'rails_helper'

RSpec.describe "hypotheses/show", :type => :view do
  before(:each) do
    @hypothesis = assign(:hypothesis, Hypothesis.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
