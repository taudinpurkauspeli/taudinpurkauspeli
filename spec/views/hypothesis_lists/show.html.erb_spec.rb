require 'rails_helper'

RSpec.describe "hypothesis_lists/show", :type => :view do
  before(:each) do
    @hypothesis_list = assign(:hypothesis_list, HypothesisList.create!(
      :hypothesis_id => 1,
      :exercise_id => 2,
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
