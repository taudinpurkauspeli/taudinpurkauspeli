require 'rails_helper'


RSpec.describe "exercises/index", :type => :view do
  before(:each) do
    assign(:exercises, [
      Exercise.create!(
        :name => "Name"
      ),
      Exercise.create!(
        :name => "Name2"
      )
    ])
  end

  it "renders a list of exercises" do
    controller.stub!(:current_user).and_return(User.create!(:name => "Koira"))
    render
    assert_select ".btn-exercise", :count => 2
  end
end
