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

   # allow(controller).to receive(:current_user).and_return(FactoryGirl.create(:user))

  end


  it "renders exercise buttons" do
    #controller.stub!(:current_user).and_return(User.create!(:name => "Koira"))

    render
    #changed current_user_is_admin stub to return true --> page shows also delete-buttons that's why there are 4 buttons
    #TODO: how to make different stubs for different tests?!
    assert_select ".btn-exercise", :count => 5
  end

end
