require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "cannot be saved with no username" do
    user = User.create username:"", realname:"Pera", password:"Salasana1", password_confirmation: "Salasana1", email:"pekka@gmail.com"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "cannot be saved with no realname" do
    user = User.create username:"Pekka", realname:"", password:"Salasana1", password_confirmation: "Salasana1", email:"pekka@gmail.com"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "cannot be saved with no email" do
    user = User.create username:"Pekka", realname:"Pera", password:"Salasana1", password_confirmation: "Salasana1", email:""

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "cannot be saved with no password" do
    user = User.create username:"Pekka", realname:"Pera", password:"", password_confirmation: "Salasana1", email:"pekka@gmail.com"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "cannot be saved with no valid password confirmation" do
    user = User.create username:"Pekka", realname:"Pera", password:"Salasana1", password_confirmation: "", email:"pekka@gmail.com"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "can be saved with correct information" do
  	user = User.new username:"Testipoika", realname:"Teppo Testailija", password:"Salainen", password_confirmation:"Salainen", email:"teppo.testailija@gmail.com"
  	user.save
  	expect(User.count).to eq(1)
  end

  it "cannot be saved if username is not unique" do
    User.create username:"Testipoika", realname:"Teppo Testailija", password:"Salainen", password_confirmation:"Salainen", email:"teppo.testailija@gmail.com"

   #FactoryGirl.create(:user)

  	user = User.create username:"Testipoika", realname:"Teppo Testailija", password:"Salainen", password_confirmation:"Salainen", email:"teppo.testailija@gmail.com"

    expect(user).not_to be_valid
  	expect(User.count).to eq(1)
  end

  it "returns correct number of completed tasks" do
    exercise = FactoryGirl.create(:exercise)
    user = FactoryGirl.create(:user, admin: false)
    task = FactoryGirl.create(:task, exercise:exercise)
    user.completed_tasks.create(task:task)
    expect(user.get_number_of_tasks_by_level(exercise, task.level)).to eq(1)
  end
end
