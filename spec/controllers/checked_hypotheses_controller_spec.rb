require 'rails_helper'

RSpec.describe CheckedHypothesesController, :type => :controller do

  let!(:user){FactoryGirl.create(:user)}
  let!(:exercise){FactoryGirl.create(:exercise)}
  let!(:task){FactoryGirl.create(:task, exercise:exercise, level:1)}
  let!(:hypothesis_group){FactoryGirl.create(:hypothesis_group)}
  let!(:hypothesis){FactoryGirl.create(:hypothesis, hypothesis_group:hypothesis_group)}
  let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, exercise:exercise, hypothesis:hypothesis, task:task)}


  let(:valid_attributes) {
    {user_id: user.id, exercise_hypothesis_id: exercise_hypothesis.id}
  }

  let(:invalid_attributes) {
    {user_id: user.id, exercise_hypothesis_id:nil}
  }

  let(:valid_session) {
    { user_id: user.id }
  }

    before :each do
      user.completed_tasks.create task_id:task.id
    end

    describe "POST create" do
     describe "with valid params" do
       it "creates a new CheckedHypothesis" do
         expect {
           post :create, {:checked_hypothesis => valid_attributes}, valid_session
           }.to change(CheckedHypothesis, :count).by(1)
         end
       end

       describe "with invalid params" do
         it "assigns a newly created but unsaved checked_hypothesis as @checked_hypothesis" do
          post :create, {:checked_hypothesis => invalid_attributes}, valid_session
          expect(assigns(:checked_hypothesis)).to be_a_new(CheckedHypothesis)
        end
      end
    end

    describe "DELETE destroy" do
     it "destroys the requested checked_hypothesis" do
       checked_hypothesis = CheckedHypothesis.create! valid_attributes
       expect {
         delete :destroy, {:id => checked_hypothesis.to_param}, valid_session
         }.to change(CheckedHypothesis, :count).by(-1)
       end
     end
   end