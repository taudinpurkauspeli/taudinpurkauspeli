require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ExerciseHypothesesController, :type => :controller do

  let!(:user){FactoryGirl.create(:user)}
  let!(:exercise){FactoryGirl.create(:exercise)}

  # This should return the minimal set of attributes required to create a valid
  # ExerciseHypothesis. As you add validations to ExerciseHypothesis, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {exercise_id: 1, hypothesis_id: 1, task_id: 1, explanation: "Oikea poisto!"}
  }


  let(:invalid_attributes) {
    {exercise_id: nil}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ExerciseHypothesesController. Be sure to keep this updated too.


  let(:valid_session) { {
      user_id: 1
  } }



  describe "GET edit" do
    it "assigns the requested exercise_hypothesis as @exercise_hypothesis" do
      exercise_hypothesis = ExerciseHypothesis.create! valid_attributes
      get :edit, {:id => exercise_hypothesis.to_param}, valid_session
      expect(assigns(:exercise_hypothesis)).to eq(exercise_hypothesis)
    end
  end
=begin
  describe "POST create" do
    describe "with valid params" do
      it "creates a new ExerciseHypothesis" do
        expect {
          post :create, {:exercise_hypothesis => valid_attributes}, valid_session
        }.to change(ExerciseHypothesis, :count).by(1)
      end

      it "assigns a newly created exercise_hypothesis as @exercise_hypothesis" do
        post :create, {:exercise_hypothesis => valid_attributes}, valid_session
        expect(assigns(:exercise_hypothesis)).to be_a(ExerciseHypothesis)
        expect(assigns(:exercise_hypothesis)).to be_persisted
      end

      it "redirects to the created exercise_hypothesis" do
        post :create, {:exercise_hypothesis => valid_attributes}, valid_session
        expect(response).to redirect_to(Hypothesis)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved exercise_hypothesis as @exercise_hypothesis" do
        post :create, {:exercise_hypothesis => invalid_attributes}, valid_session
        expect(assigns(:exercise_hypothesis)).to be_a_new(ExerciseHypothesis)
      end
    end
  end
=end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {exercise_id: 2, hypothesis_id: 2, explanation: "Oikea poisto!"}
      }

      it "updates the requested exercise_hypothesis" do
        exercise_hypothesis = ExerciseHypothesis.create! valid_attributes
        put :update, {:id => exercise_hypothesis.to_param, :exercise_hypothesis => new_attributes}, valid_session
        exercise_hypothesis.reload
        expect(exercise_hypothesis.exercise_id).to eq(2)
        expect(exercise_hypothesis.hypothesis_id).to eq(2)
      end

      it "assigns the requested exercise_hypothesis as @exercise_hypothesis" do
        exercise_hypothesis = ExerciseHypothesis.create! valid_attributes
        put :update, {:id => exercise_hypothesis.to_param, :exercise_hypothesis => valid_attributes}, valid_session
        expect(assigns(:exercise_hypothesis)).to eq(exercise_hypothesis)
      end

      it "redirects to the exercise_hypothesis" do
        exercise_hypothesis = ExerciseHypothesis.create! valid_attributes
        put :update, {:id => exercise_hypothesis.to_param, :exercise_hypothesis => valid_attributes}, valid_session
        expect(response).to redirect_to(hypotheses_url)
      end
    end


    describe "with invalid params" do
      it "assigns the exercise_hypothesis as @exercise_hypothesis" do
        exercise_hypothesis = ExerciseHypothesis.create! valid_attributes
        put :update, {:id => exercise_hypothesis.to_param, :exercise_hypothesis => invalid_attributes}, valid_session
        expect(assigns(:exercise_hypothesis)).to eq(exercise_hypothesis)
      end
    end
  end


  describe "DELETE destroy" do
    it "destroys the requested exercise_hypothesis" do
      exercise_hypothesis = ExerciseHypothesis.create! valid_attributes
      expect {
        delete :destroy, {:id => exercise_hypothesis.to_param}, valid_session
      }.to change(ExerciseHypothesis, :count).by(-1)
    end

    it "redirects to the exercise_hypotheses list" do
      exercise_hypothesis = ExerciseHypothesis.create! valid_attributes
      delete :destroy, {:id => exercise_hypothesis.to_param}, valid_session
      expect(response).to redirect_to(hypotheses_url)
    end
  end

end

