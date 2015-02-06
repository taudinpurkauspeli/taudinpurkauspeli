require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "cannot be saved with no username" do
    user = User.new username:nil
    user.save
    expect(User.count).to eq(0)
  end

  it "cannot be saved with no realname" do
    user = User.new realname:nil
    user.save
    expect(User.count).to eq(0)
  end

  it "cannot be saved with no email" do
    user = User.new email:nil
    user.save
    expect(User.count).to eq(0)
  end

  it "cannot be saved with no password" do
    user = User.new password:nil
    user.save
    expect(User.count).to eq(0)
  end

  it "cannot be saved with no valid password confirmation" do
    user = User.new password:"Koira", password_confirmation:nil
    user.save
    expect(User.count).to eq(0)
  end

  it "can be saved with correct information" do
  	user = User.new username:"Testipoika", realname:"Teppo Testailija", password:"Salainen", password_confirmation:"Salainen", email:"teppo.testailija@gmail.com"
  	user.save
  	expect(User.count).to eq(1)
  end

  it "cannot be saved if username is not unique" do
  	user = User.new username:"Testipoika", realname:"Teppo Testailija", password:"Salainen", password_confirmation:"Salainen", email:"teppo.testailija@gmail.com"
  	user.save
  	user = User.new username:"Testipoika", realname:"Teppo Testailija", password:"Salainen", password_confirmation:"Salainen", email:"teppo.testailija@gmail.com"
  	user.save
  	expect(User.count).to eq(1)
  end
end
