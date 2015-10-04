require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  describe "cannot be saved" do

    it "with no username" do
      user = User.create username:"", first_name:"Pera", last_name: "Peranen", password:"Salasana1", password_confirmation: "Salasana1", email:"pekka@gmail.com", student_number: "000000001", starting_year: 2000

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "with no names" do
      user = User.create username:"Pekka", first_name:"", last_name: "", password:"Salasana1", password_confirmation: "Salasana1", email:"pekka@gmail.com", student_number: "000000001", starting_year: 2000

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "with too short first_name" do
      user = User.create username:"Pekka", first_name:"Te", last_name: "Test", password:"Salasana1", password_confirmation: "Salasana1", email:"pekka@gmail.com", student_number: "000000001", starting_year: 2000

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "with too short last_name" do
      user = User.create username:"Pekka", first_name:"Test", last_name: "Te", password:"Salasana1", password_confirmation: "Salasana1", email:"pekka@gmail.com", student_number: "000000001", starting_year: 2000

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "with no email" do
      user = User.create username:"Pekka", first_name:"Pera", last_name: "Peranen", password:"Salasana1", password_confirmation: "Salasana1", email:"", student_number: "000000001", starting_year: 2000

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "with no student number" do
      user = User.create username:"Pekka", first_name:"Pera", last_name: "Peranen", password:"Salasana1", password_confirmation: "Salasana1", email:"pekka@p.com", student_number: "", starting_year: 2000

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "with too short student number" do
      user = User.create username:"Pekka", first_name:"Pera", last_name: "Peranen", password:"Salasana1", password_confirmation: "Salasana1", email:"pekka@p.com", student_number: "12345678", starting_year: 2000

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "with no starting year" do
      user = User.create username:"Pekka", first_name:"Pera", last_name: "Peranen", password:"Salasana1", password_confirmation: "Salasana1", email:"pekka@p.com", student_number: "123456789", starting_year: nil

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "with no password" do
      user = User.create username:"Pekka", first_name:"Pera", last_name: "Peranen", password:"", password_confirmation: "Salasana1", email:"pekka@gmail.com", student_number: "000000001", starting_year: 2000

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end


    it "with valid password confirmation" do
      user = User.create username:"Pekka", first_name:"Pera", last_name: "Peranen", password:"Salasana1", password_confirmation: "", email:"pekka@gmail.com", student_number: "000000001", starting_year: 2000

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "when student number contains other characters than numbers" do
      user = User.create username:"Pekka", first_name:"Pera", last_name: "Peranen", password:"Salasana1", password_confirmation: "Salasana1", email:"pekka@p.com", student_number: "12345678A", starting_year: 2000

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "if username is not unique" do
      User.create username:"Testipoika", first_name:"Teppo", last_name: "Testailija", password:"Salainen", password_confirmation:"Salainen", email:"teppo.testailija@gmail.com", student_number: "000000000", starting_year: 2000

      user = User.create username:"Testipoika", first_name:"Teppo", last_name: "Testailija", password:"Salainen", password_confirmation:"Salainen", email:"teppo.testailija@gmail.com", student_number: "000000001", starting_year: 2000

      expect(user).not_to be_valid
      expect(User.count).to eq(1)
    end

    it "if student number is not unique" do
      User.create username:"Testipoika", first_name:"Teppo", last_name: "Testailija", password:"Salainen", password_confirmation:"Salainen", email:"teppo.testailija@gmail.com", student_number: "000000000", starting_year: 2000

      user = User.create username:"Testikaveri", first_name:"Teppo", last_name: "Testailija", password:"Salainen", password_confirmation:"Salainen", email:"teppo.testailija@gmail.com", student_number: "000000000", starting_year: 2000

      expect(user).not_to be_valid
      expect(User.count).to eq(1)
    end

  end

  it "can be saved with correct information" do
    user = User.new username:"Testipoika", first_name:"Teppo", last_name: "Testailija", password:"Salainen", password_confirmation:"Salainen", email:"teppo.testailija@gmail.com", student_number: "000000000", starting_year: 2000
    user.save
    expect(User.count).to eq(1)
  end

  describe "can determine correct" do
    let!(:exercise){FactoryGirl.create(:exercise)}
    let!(:user){FactoryGirl.create(:user, admin: false)}
    let!(:task){FactoryGirl.create(:task, exercise:exercise)}
    let!(:task2){FactoryGirl.create(:task, name:"Hoida", exercise:exercise, level:2)}
    let!(:task3){FactoryGirl.create(:task, name:"Hoida eläintä", exercise:exercise, level:3)}
    let!(:task4){FactoryGirl.create(:task, name:"Hoida asiakasta", exercise:exercise, level:3)}
    let!(:completed_task){FactoryGirl.create(:completed_task, task:task, user:user)}
    let!(:completed_task2){FactoryGirl.create(:completed_task, task:task2, user:user)}

    it "number of completed tasks by level" do
      expect(user.get_number_of_tasks_by_level(exercise, task.level)).to eq(1)
    end

    it "number of completed tasks by exercise" do
      expect(user.get_number_of_completed_tasks_by_exercise(exercise)).to eq(2)
    end

    it "percent of completed tasks by exercise" do
      expect(user.get_percent_of_completed_tasks_of_exercise(exercise)).to eq(50)
    end
  end

  describe "has_completed" do
    let!(:exercise){FactoryGirl.create(:exercise)}
    let!(:user){FactoryGirl.create(:user)}
    let!(:task){FactoryGirl.create(:task, exercise:exercise)}
    let!(:subtask){FactoryGirl.create(:subtask, task:task)}

    before(:each) do
      user.complete_subtask(subtask)
      user.complete_task(task)
      user.complete_exercise(exercise)
    end

    it "finds completed task" do
      expect(user.has_completed?(task)).to eq(true)
    end

    it "finds completed subtask" do
      expect(user.has_completed?(subtask)).to eq(true)
    end

    it "finds completed exercise" do
      expect(user.has_completed?(exercise)).to eq(true)
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

  describe "can manage hypotheses by" do
    let!(:exercise){FactoryGirl.create(:exercise)}
    let!(:user){FactoryGirl.create(:user, admin:false)}
    let!(:hypothesis){FactoryGirl.create(:hypothesis)}
    let!(:hypothesis2){FactoryGirl.create(:hypothesis, name:"Bakteeritauti")}
    let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis)}
    let!(:exercise_hypothesis2){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis2)}

    it "checking one hypothesis" do
      expect {
        user.check_hypothesis(exercise_hypothesis)
      }.to change{user.exercise_hypotheses.count}.by(1)
    end

    it "checking all hypotheses of one case" do
      expect {
        user.check_all_hypotheses(exercise)
      }.to change{user.exercise_hypotheses.count}.by(2)
    end

    it "getting checked hypothesis" do
      checked_hypothesis = user.check_hypothesis(exercise_hypothesis)
      expect(user.get_checked_hypothesis(exercise_hypothesis)).to eq(checked_hypothesis)
    end

    describe "checking that hypothesis" do
      it "has been checked" do
        user.check_hypothesis(exercise_hypothesis)
        expect(user.has_checked_hypothesis?(exercise_hypothesis)).to eq(true)
      end

      it "has not been checked" do
        expect(user.has_checked_hypothesis?(exercise_hypothesis)).to eq(false)
      end
    end
  end

  describe "can check that question" do
    let!(:user){FactoryGirl.create(:user, admin:false)}
    let!(:question){FactoryGirl.create(:question)}
    let!(:question2){FactoryGirl.create(:question, title: "Lehmän toiset sisarukset")}
    let!(:asked_question){FactoryGirl.create(:asked_question, user:user, question:question)}

    it "has been asked" do
      expect(user.has_asked_question?(question)).to eq(true)
    end

    it "has not been asked" do
      expect(user.has_asked_question?(question2)).to eq(false)
    end
  end

end
