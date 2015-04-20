require 'rails_helper'

RSpec.describe HypothesisGroupsController, :type => :controller do

  let!(:user){FactoryGirl.create(:user)}
  let!(:exercise){FactoryGirl.create(:exercise)}
  # This should return the minimal set of attributes required to create a valid
  # HypothesisGroup. As you add validations to HypothesisGroup, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {name: "Bakteeritauti"} }
  let(:invalid_attributes) { {name: ""} }


  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HypothesesController. Be sure to keep this updated too.
  let(:valid_session) { {      user_id: 1} }

  describe "POST create" do
    describe "with valid params" do
      it "creates a new HypothesisGroup" do
        expect {
          post :create, {:hypothesis_group => valid_attributes}, valid_session
          }.to change(HypothesisGroup, :count).by(1)
      end

      it "assigns a newly created hypothesis group as @hypothesis_group" do
        post :create, {:hypothesis_group => valid_attributes}, valid_session
        expect(assigns(:hypothesis_group)).to be_a(HypothesisGroup)
        expect(assigns(:hypothesis_group)).to be_persisted
      end

      it "redirects to the created hypothesis group" do
        post :create, {:hypothesis_group => valid_attributes}, valid_session
        expect(response).to redirect_to(hypotheses_path(:layout => true))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hypothesis group as @hypothesis_group" do
        post :create, {:hypothesis_group => invalid_attributes}, valid_session
        expect(assigns(:hypothesis_group)).to be_a_new(HypothesisGroup)
      end
    end
  end

    describe "DELETE destroy" do
      it "destroys the requested hypothesis group" do
        hypothesis_group = HypothesisGroup.create! valid_attributes
        expect {
          delete :destroy, {:id => hypothesis_group.to_param}, valid_session
          }.to change(HypothesisGroup, :count).by(-1)
        end

        it "redirects to the hypotheses list" do
          hypothesis_group = HypothesisGroup.create! valid_attributes
          delete :destroy, {:id => hypothesis_group.to_param}, valid_session
          expect(response).to redirect_to(hypotheses_path(:layout => true))
        end
      end

    end
