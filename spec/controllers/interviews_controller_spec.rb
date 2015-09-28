require 'rails_helper'

RSpec.describe InterviewsController, :type => :controller do

	let!(:exercise){FactoryGirl.create(:exercise)}
	let!(:user){FactoryGirl.create(:user)}
	let!(:task){FactoryGirl.create(:task, exercise:exercise)}
	let!(:subtask){FactoryGirl.create(:subtask, task:task)}

	let(:valid_attributes) {
		{subtask_id: subtask.id, title: "Tapausmäärittely"}
	}

	let(:invalid_attributes) {
		{subtask_id: nil, title: ""}
	}

	let(:valid_session) { {
			user_id: user.id, task_id: task.id, exercise_id: 1}
	}

	describe "GET new" do
		it "assigns a new interview as @interview" do
			get :new, {}, valid_session
			expect(assigns(:interview)).to be_a_new(Interview)
		end
	end

	describe "GET edit" do

		let(:interview){FactoryGirl.create(:interview, subtask:subtask)}

		it "assigns the requested interview as @interview" do
			get :edit, {:id => interview.to_param}, valid_session
			expect(assigns(:interview)).to eq(interview)
		end

		it "assigns new question as @new_question" do
			get :edit, {:id => interview.to_param}, valid_session
			expect(assigns(:new_question)).to be_a_new(Question)
		end

		it "assigns asked question as @new_asked_question" do
			get :edit, {:id => interview.to_param}, valid_session
			expect(assigns(:new_asked_question)).to be_a_new(AskedQuestion)
		end
		it "assigns new question group as @new_question_group" do
			get :edit, {:id => interview.to_param}, valid_session
			expect(assigns(:new_question_group)).to be_a_new(QuestionGroup)
		end

	end

	describe "POST create" do
		describe "with valid params" do
			it "creates a new Interview" do
				expect {
					post :create, {:interview => valid_attributes}, valid_session
				}.to change(Interview, :count).by(1)
			end
		end

		describe "with invalid params" do
			it "does not create a new Interview" do
				expect {
					post :create, {:interview => invalid_attributes}, valid_session
				}.not_to change(Interview, :count)
			end
		end

	end

	describe "PUT update" do

		let(:interview){FactoryGirl.create(:interview, subtask:subtask)}

		describe "with valid params" do
			let(:new_attributes) {
				{title: "Haastattelun uusi nimi"}
			}

			it "assigns the requested interview as @interview" do
				put :update, {:id => interview.to_param, :interview => new_attributes}, valid_session
				expect(assigns(:interview)).to eq(interview)
			end
		end

		describe "with invalid params" do

			it "assigns the requested interview as @interview" do
				put :update, {:id => interview.to_param, :interview => invalid_attributes}, valid_session
				expect(assigns(:interview)).to eq(interview)
			end
		end

    end

    describe "ask_question" do
    	let(:interview){FactoryGirl.create(:interview, subtask:subtask)}
    	let(:question){FactoryGirl.create(:question, interview:interview)}

    	it "new asked question to user" do

    		expect {
    			post :ask_question, {:id => interview.to_param, :question_id => question.to_param}, valid_session
    		}.to change(user.asked_questions, :count).by(1)
    	end

    end

    describe "check_answers" do
    	let(:interview){FactoryGirl.create(:interview, subtask:subtask)}

    	it "completes subtask" do
			expect {
    			post :check_answers, {:id => interview.to_param}, valid_session
    		}.to change(CompletedSubtask, :count).by(1)
    	end

   #  	let(:question){FactoryGirl.create(:question, interview:interview)}
    	

   #  	 it "does not complete subtask if required questions not asked" do
			# expect {
   #  			post :check_answers, {:id => interview.to_param}, valid_session
   #  		}.not_to change(CompletedSubtask, :count)
   #  	end

    end

end