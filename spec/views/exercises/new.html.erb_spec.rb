=begin
require 'rails_helper'
RSpec.describe "exercises/new", :type => :view do
  before(:each) do
    assign(:exercise, Exercise.new(
      :name => "Lihanautakuolemat"
    ))
  end

  it "renders new exercise form" do
    render

    assert_select "form[action=?][method=?]", exercises_path, "post" do

      assert_select "input#exercise_name[name=?]", "exercise[name]"
    end
  end
end
=end