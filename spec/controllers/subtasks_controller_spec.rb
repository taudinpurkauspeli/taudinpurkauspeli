require 'rails_helper'

RSpec.describe SubtasksController, :type => :controller do

	let!(:user){FactoryGirl.create(:user)}
	#let!(:task_text){FactoryGirl.create(:task_text)}
	#let!(:multichoice){FactoryGirl.create(:multichoice)}
	let!(:task){FactoryGirl.create(:task)}

	let(:valid_attributes) {
		{task_id: 1}
	}

	let(:invalid_attributes) {
		{task_id: nil}
	}

	let(:valid_session) { {
			user_id: 1}
	}

	describe "POST create" do
		describe "with valid params" do
			it "creates a new Subtask" do
				expect {
					post :create, {:subtask => valid_attributes}, valid_session
				}.to change(Subtask, :count).by(1)
			end
		end
	end

	describe "DELETE destroy" do
		it "destroys the requested subtask" do
			subtask = Subtask.create! valid_attributes

			expect {
				delete :destroy, {:id => subtask.to_param }, valid_session
			}.to change(Subtask, :count).by(-1)

		end
	end
end