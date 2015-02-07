require 'rails_helper'

include RSpec::Mocks::ExampleMethods


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


  it "renders a list of exercises again" do
    #controller.stub!(:current_user).and_return(User.create!(:name => "Koira"))

    render
    assert_select ".btn-exercise", :count => 2
  end

end
