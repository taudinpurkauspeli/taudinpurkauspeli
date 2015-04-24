require 'rails_helper'

RSpec.describe Subtask, type: :model do
	it "has the ids set correctly" do
     subtask = Subtask.new task_id: 1

    expect(subtask.task_id).to eq(1)

  end

  describe "with correct ids" do
    let!(:task){FactoryGirl.create(:task, exercise_id:1, level:1)}
    let!(:subtask){FactoryGirl.create(:subtask, task_id:1)}

    it "is saved" do
      expect(subtask).to be_valid
      expect(Subtask.count).to eq(1)
    end
  end

  describe "string methods" do
    describe "return correctly for" do
      let!(:task){FactoryGirl.create(:task, exercise_id:1, level:1)}
      let!(:subtask){FactoryGirl.create(:subtask, task:task)}

      describe "multichoice" do
        let(:s){
          subtask.create_multichoice(question:"This is a test")
          subtask
        }

        it "template" do
          expect(s.template).to eq("multichoice")
        end

        it "to_s" do
          expect(s.to_s).to eq("Monivalinta: This is a ...")
        end
      end

      describe "task_text" do
        let(:s){
          subtask.create_task_text(content:"This is a test")
          subtask
        }

        it "template" do
          expect(s.template).to eq("task_text")
        end

        it "to_s" do
          expect(s.to_s).to eq("Teksti: This is a ...")
        end
      end

      describe "interview" do
        let(:s){
          subtask.create_interview(title:"This is a test")
          subtask
        }

        it "template" do
          expect(s.template).to eq("interview")
        end

        it "to_s" do
          expect(s.to_s).to eq("Pohdinta: This is a ...")
        end
      end
 
      describe "conclusion" do
        let(:s){
          subtask.create_conclusion(title:"This is a test")
          subtask
        }

        it "template" do
          expect(s.template).to eq("conclusion")
        end

        it "to_s" do
          expect(s.to_s).to eq("Päätöstoimenpide: This is a ...")
        end
      end
    end
  end

  describe "level" do
    let!(:task){FactoryGirl.create(:task, exercise_id:1, level:1)}
    let!(:user){FactoryGirl.create(:user)}

    it "is set correctly when no subtasks exist" do
      subtask = Subtask.create task_id:task.id
      expect(subtask.level).to eq(1)
    end

    it "is set correctly when prior subtasks exist" do
      for i in 0...3
        Subtask.create task_id:task.id
      end
      subtask = Subtask.create task_id:task.id
      expect(subtask.level).to eq(4)
    end

    it "sorts subtasks correctly" do
      actual = Array.new(5)
      for i in 0...5
        actual[i] = Subtask.create task_id:task. id
      end
      actual[1].update(level:5)
      actual[4].update(level:2)

      actual = task.subtasks.map(&:level)
      expected = [1, 2, 3, 4, 5]

      expect(actual).to eq expected
    end

   

 

    describe "prevents user from starting" do

           
      it "other than the first subtask" do
        subs = populate_task(task)
        
        actual = user.can_complete_subtask?(task, subs[5])
        expected = false

        expect(actual).to eq expected
      end

      it "the wrong subtask when user has completed some already" do
        subs = populate_task(task)
        populate_user_with_subtasks(user, subs)

        actual = user.can_complete_subtask?(task, subs[8])
        expected = false

        expect(actual).to eq expected
      end
    end

    describe "lets user start" do

      it "the first subtask" do
        subs = populate_task(task)
        actual = user.can_complete_subtask?(task, subs[0])
        expected = true

        expect(actual).to eq expected
      end

      it "the next subtask" do
        subs = populate_task(task)
        populate_user_with_subtasks(user, subs)

        actual = user.can_complete_subtask?(task, subs[3])
        expected = true

        expect(actual).to eq expected
      end
    end
  end
end
