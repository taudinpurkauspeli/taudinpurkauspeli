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

describe "has_completed" do
  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:user){FactoryGirl.create(:user)}
  let!(:task){FactoryGirl.create(:task, exercise:exercise)}
  let!(:subtask){FactoryGirl.create(:subtask, task:task)}

  before(:each) do
    user.complete_subtask(subtask)
    user.complete_task(task)
  end

  it "finds completed task" do
    expect(user.has_completed?(task)).to eq(true)
  end

  it "finds completed subtask" do
    expect(user.has_completed?(subtask)).to eq(true)
  end
end

describe "can_start?" do
  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:user){FactoryGirl.create(:user)}
  let!(:task1){FactoryGirl.create(:task, exercise:exercise, level:1)}
  let!(:task2){FactoryGirl.create(:task, name:"Alt", exercise:exercise, level:2)}
  let!(:task3){FactoryGirl.create(:task, name:"Alter", exercise:exercise, level:3)}

  it "lets user start first task" do
    expect(user.can_start?(task1)).to eq(true)
  end

  it "prevents user from starting wrong task" do
    expect(user.can_start?(task2)).to eq(false)
  end

  it "lets user start any correct task" do
    user.complete_task(task1)
    expect(user.can_start?(task2)).to eq(true)
  end
end

describe "can add completed" do
  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:user){FactoryGirl.create(:user)}
  let!(:task){FactoryGirl.create(:task, exercise:exercise)}
  let!(:subtask){FactoryGirl.create(:subtask, task:task)}

  it "subtasks" do
    expect {
      user.complete_subtask(subtask)
      }.to change{user.subtasks.count}.by(1)
  end

  it "tasks" do
    expect {
      user.complete_task(task)
      }.to change{user.tasks.count}.by(1)
  end

  describe "exercises" do
    let!(:task){FactoryGirl.create(:task, exercise:exercise, name:'Koira')}
    let!(:subtask_last){FactoryGirl.create(:subtask, task:task)}

    it "by direct method call" do
      expect {
        user.complete_exercise(exercise)
        }.to change{user.exercises.count}.by(1)
    end

    it "by completing subtasks" do
      user.complete_subtask(subtask)
      expect {
        user.complete_subtask(subtask_last)
        }.to change{user.exercises.count}.by(1)
    end
  end
end
end