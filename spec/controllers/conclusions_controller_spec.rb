require 'rails_helper'

RSpec.describe ConclusionsController, :type => :controller do

	let!(:exercise){FactoryGirl.create(:exercise)}
	let!(:user){FactoryGirl.create(:user)}
	let!(:task){FactoryGirl.create(:task, exercise:exercise)}
	let!(:subtask){FactoryGirl.create(:subtask, task:task)}

	let!(:hypothesis){FactoryGirl.create(:hypothesis)}
	let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, hypothesis:hypothesis, exercise:exercise)}
	let!(:wrong_exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis, hypothesis:hypothesis, exercise:exercise)}


	let(:valid_attributes) {
		{subtask_id: subtask.id, title: "Viimeinen kysymys", exercise_hypothesis_id: exercise_hypothesis.id}
	}

	let(:invalid_attributes) {
		{subtask_id: subtask.id, title: ""}
	}

	let(:valid_session) { {
			user_id: user.id, task_id: task.id, exercise_id: exercise.id, exhyp_id: exercise_hypothesis.id}
	}

	describe "GET new" do
		it "assigns a new conclusion as @conclusion" do
			get :new, {}, valid_session
			expect(assigns(:conclusion)).to be_a_new(Conclusion)
		end
	end

	describe "POST create" do
		describe "with valid params" do
			it "creates a new Conclusion" do
				expect {
					post :create, {:conclusion => valid_attributes}, valid_session
				}.to change(Conclusion, :count).by(1)
			end
		end

		describe "with invalid params" do
	      it "assigns a newly created but unsaved conclusion as @conclusion" do
	        post :create, {:conclusion => invalid_attributes}, valid_session
	        expect(assigns(:conclusion)).to be_a_new(Conclusion)
	      end

	      it "redirects to the 'new' template" do
	        post :create, {:conclusion => invalid_attributes}, valid_session
	        expect(response).to redirect_to(new_conclusion_path(:layout => true))
	      end
	    end
	end

	describe "PUT update" do
		describe "with valid params" do
			let(:new_attributes) {
				{title: "Vihonviimeinen kysymys"}
			}

			it "assigns the requested conclusion as @conclusion" do
				conclusion = Conclusion.create! valid_attributes
				put :update, {:id => conclusion.to_param, :conclusion => new_attributes}, valid_session
				expect(assigns(:conclusion)).to eq(conclusion)
			end
		end

		describe "with invalid params" do
	      it "assigns the conclusion as @conclusion" do
	        conclusion = Conclusion.create! valid_attributes
	        put :update, {:id => conclusion.to_param, :conclusion => invalid_attributes}, valid_session
	        expect(assigns(:conclusion)).to eq(conclusion)
	      end

	      it "redirects to the 'edit' template" do
	        conclusion = Conclusion.create! valid_attributes
	        put :update, {:id => conclusion.to_param, :conclusion => invalid_attributes}, valid_session
	        expect(response).to redirect_to(edit_conclusion_path(conclusion, :layout => true))
	      end
	    end
	end

	    describe "check_answers" do

	    	it "completes subtask" do
				expect {
					conclusion = Conclusion.create! valid_attributes
	     			post :check_answers, {:id => conclusion.to_param, :exhyp_id => conclusion.exercise_hypothesis.id}, valid_session
	     		}.to change(CompletedSubtask, :count).by(1)
	     	end

	     	 it "does not complete subtask if wrong hypothesis is chosen" do
				expect {
					conclusion = Conclusion.create! valid_attributes
	     			post :check_answers, {:id => conclusion.to_param, :exhyp_id => wrong_exercise_hypothesis.id }, valid_session
	     		}.not_to change(CompletedSubtask, :count)
	     	end

   	 end

    	describe "DELETE create" do

		    	it "destroys the requested conclusion" do
		    	conclusion = Conclusion.create! valid_attributes
		      	expect {
		        	delete :destroy, {:id => conclusion.to_param}, valid_session
		      	}.to change(Conclusion, :count).by(-1)
		    	end

		    	it "destroys the corresponding Task" do
		    	conclusion = Conclusion.create! valid_attributes
		      	expect {
		        	delete :destroy, {:id => conclusion.to_param}, valid_session
		      	}.to change(Task, :count).by(-1)
		    	end

			    it "redirects to the task list" do
			      conclusion = Conclusion.create! valid_attributes
			      delete :destroy, {:id => conclusion.to_param}, valid_session
			      expect(response).to redirect_to(tasks_url(:layout => true))
			    end

		end

end
