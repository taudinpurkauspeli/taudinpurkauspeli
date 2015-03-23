require 'rails_helper'

RSpec.describe CheckedHypothesesController, :type => :controller do

  let!(:user){FactoryGirl.create(:user, id: 1)}
  let!(:task){FactoryGirl.create(:task, id: 1)}
  let!(:hypothesis){FactoryGirl.create(:hypothesis)}
  let!(:exercise){FactoryGirl.create(:exercise, id: 1)}
  let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, id: 1, exercise_id: 1)}
  let!(:hypothesis_group){FactoryGirl.create(:hypothesis_group)}

  let(:valid_attributes) {
    {user_id: 1, exercise_hypothesis_id: 1}
  }

  let(:invalid_attributes) {
    {user_id: 1, exercise_hypothesis_id:nil}
  }

  let(:valid_session) { {
    user_id: 1
    } }

    before :each do
      user.completed_tasks.create task_id:1
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