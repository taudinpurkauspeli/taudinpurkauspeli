require 'rails_helper'

RSpec.describe "users/edit", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :username => "MyString",
      :password => "Salasana1",
      :password_confirmation => "Salasana1",
      :email => "osoite@osoite.com",
      :realname => "Nimi"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_username[name=?]", "user[username]"
    end
  end
end
