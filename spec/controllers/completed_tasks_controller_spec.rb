require 'rails_helper'

RSpec.describe CompletedTasksController, :type => :controller do

  let!(:user){FactoryGirl.create(:user)}
  let!(:hypothesis_group){FactoryGirl.create(:hypothesis_group)}
  let!(:hypothesis){FactoryGirl.create(:hypothesis, hypothesis_group:hypothesis_group)}
  let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis)}
  let!(:exercise){FactoryGirl.create(:exercise)}

  let(:valid_attributes) {
    { user_id: 1, task_id: 1 }
  }

  let(:invalid_attributes) {
    { user_id: 1 }
  }

  let(:valid_session) {
    { user_id: 1 }
  }

    describe "POST create" do
     describe "with valid params" do
       it "creates a new CompletedTask" do
         expect {
            post :create, { :completed_task => valid_attributes }, valid_session
         }.to change(CompletedTask, :count).by(1)
         end
       end

       describe "with invalid params" do
         it "assigns a newly created but unsaved completed_task as @completed_task" do
          post :create, {:completed_task => invalid_attributes}, valid_session
          expect(assigns(:completed_task)).to be_a_new(CompletedTask)
        end
      end
    end
  end