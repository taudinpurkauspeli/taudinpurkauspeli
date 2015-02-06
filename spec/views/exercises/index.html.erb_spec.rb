require 'rails_helper'


RSpec.describe "exercises/index", :type => :view do

  let!(:user){FactoryGirl.create(:user)}

  before(:each) do

    assign(:exercises, [
      Exercise.create!(
        :name => "Name"
      ),
      Exercise.create!(
        :name => "Name2"
      )
    ])


    allow(controller).to receive(:current_user).and_return(FactoryGirl.create(:user))




  end


  #it "renders a list of exercises" do
    #controller.stub!(:current_user).and_return(User.create!(:name => "Koira"))

   # assert_select ".btn-exercise", :count => 2
  #end

end
