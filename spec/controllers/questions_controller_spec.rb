require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

	let!(:user){FactoryGirl.create(:user)}
	let!(:task){FactoryGirl.create(:task)}
	let!(:interview){FactoryGirl.create(:interview)}

	let(:valid_attributes) {{title: "Hygienia tilalla", content: "Käsiä on pyritty pesemään", interview_id: interview.id
	}}

	let(:invalid_attributes) {{content: nil, explanation: nil, interview_id: 1}}

	let(:valid_session) { {
			user_id: 1, task_id: 1
	} }

	describe "POST create" do
		describe "with valid params" do
			it "creates a new Question" do
				expect {
					post :create, {:question => valid_attributes}, valid_session
				}.to change(Question, :count).by(1)
			end
		end

	end

	describe "POST create" do
		describe "with invalid params" do
			it "does not create a new Question" do
				expect {
					post :create, {:question => invalid_attributes}, valid_session
				}.not_to change(Question, :count)
			end
		end

	end

	describe "PUT update" do
		describe "with valid params" do
			let(:new_attributes) {
				{title: "Onko tilalla muita eläimiä?", content: "Muutama koira löytyy."}
			}

			it "assigns the requested question as @question" do
				question = Question.create! valid_attributes
				put :update, {:id => question.to_param, :question => valid_attributes}, valid_session
				expect(assigns(:question)).to eq(question)
			end

		end

		describe "with invalid params" do
			it "assigns the requested question as @question" do
				question = Question.create! valid_attributes
				put :update, {:id => question.to_param, :question => invalid_attributes}, valid_session
				expect(assigns(:question)).to eq(question)
			end

		end

	end

	describe "DELETE destroy" do
		it "destroys the requested question" do
			question = Question.create! valid_attributes
			expect {
				delete :destroy, {:id => question.to_param}, valid_session
			}.to change(Question, :count).by(-1)
		end

		it "redirects to the interview edit" do
			question = Question.create! valid_attributes
			delete :destroy, {:id => question.to_param}, valid_session
			expect(response).to redirect_to(edit_interview_path(:layout => true))
		end
	end

end
