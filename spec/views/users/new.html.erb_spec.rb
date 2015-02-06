require 'rails_helper'

RSpec.describe "users/new", :type => :view do
  before(:each) do
    assign(:user, User.new(
      :username => "MyString",
      :password => "Salasana1",
      :password_confirmation => "Salasana1",
      :admin => true,
      :realname => "Nimi"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_username[name=?]", "user[username]"
    end
  end
end
