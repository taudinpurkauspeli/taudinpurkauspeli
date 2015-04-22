require 'rails_helper'

RSpec.describe ConclusionsController, :type => :controller do

	let!(:exercise){FactoryGirl.create(:exercise)}
	let!(:user){FactoryGirl.create(:user)}
	let!(:task){FactoryGirl.create(:task, exercise:exercise)}
	let!(:subtask){FactoryGirl.create(:subtask, task:task)}

	let!(:hypothesis){FactoryGirl.create(:hypothesis)}
	let!(:exercise_hypothesis){FactoryGirl.create(:exercise_hypothesis,)}

	let(:valid_attributes) {
		{subtask_id: subtask.id, title: "Viimeinen kysymys"}
	}

	let(:valid_session) { {
			user_id: user.id, task_id: task.id, exercise_id: exercise.id}
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
	end

	    describe "check_answers" do
    	let(:conclusion){FactoryGirl.create(:conclusion, subtask:subtask)}

   #  	it "completes subtask" do
			# expect {
   #  			post :check_answers, {:id => conclusion.to_param}, valid_session
   #  		}.to change(CompletedSubtask, :count).by(1)
   #  	end

   #  	let(:question){FactoryGirl.create(:question, interview:interview)}
    	

   #  	 it "does not complete subtask if required questions not asked" do
			# expect {
   #  			post :check_answers, {:id => interview.to_param}, valid_session
   #  		}.not_to change(CompletedSubtask, :count)
   #  	end

    end

end
