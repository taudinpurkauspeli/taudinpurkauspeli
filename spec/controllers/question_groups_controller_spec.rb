require 'rails_helper'

RSpec.describe QuestionGroupsController, :type => :controller do
	  let!(:user){FactoryGirl.create(:user)}
	  let!(:exercise){FactoryGirl.create(:exercise)}
	  let!(:task){FactoryGirl.create(:task, exercise:exercise)}
	  let!(:subtask){FactoryGirl.create(:subtask, task:task)}
	  let!(:interview){FactoryGirl.create(:interview, subtask:subtask)}

	   let(:valid_session) { {  user_id: 1, task_id: task.id} }

	   let(:valid_attributes) { {title: "Liian henkilökohtaiset kysymykset", interview_id: interview.id} }
	   let(:invalid_attributes) { {title: "", interview_id: interview.id }}



  describe "POST create" do
    describe "with valid params" do
      it "creates a new QuestionGroup" do
        expect {
          post :create, {:question_group => valid_attributes}, valid_session
        }.to change(QuestionGroup, :count).by(1)
      end

      it "assigns a newly created hypothesis group as @question_group" do
        post :create, {:question_group => valid_attributes}, valid_session
        expect(assigns(:question_group)).to be_a(QuestionGroup)
        expect(assigns(:question_group)).to be_persisted
      end

      it "redirects to the interview edit group" do
        post :create, {:question_group => valid_attributes}, valid_session
        expect(response).to redirect_to(edit_interview_path(interview.id, :layout => true))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved question group as @question_group" do
        post :create, {:question_group => invalid_attributes}, valid_session
        expect(assigns(:question_group)).to be_a_new(QuestionGroup)
      end
    end
  end


  describe "DELETE destroy" do
    it "destroys the requested question group" do
      question_group = QuestionGroup.create! valid_attributes
      expect {
        delete :destroy, {:id => question_group.to_param}, valid_session
      }.to change(QuestionGroup, :count).by(-1)
    end

    # it "redirects to the interview edit" do
    #   question_group = QuestionGroup.create! valid_attributes
    #   delete :destroy, {:id => question_group.to_param}, valid_session
    #   expect(response).to redirect_to(edit_interview_path(interview.id, :layout => true))
    # end
  end

end