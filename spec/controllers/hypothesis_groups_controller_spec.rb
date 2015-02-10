require 'rails_helper'

RSpec.describe HypothesisGroupsController, :type => :controller do

  let!(:user){FactoryGirl.create(:user)}
  # This should return the minimal set of attributes required to create a valid
  # HypothesisGroup. As you add validations to HypothesisGroup, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: "Bakteeritauti"}
  }

  let!(:exercise){
    FactoryGirl.create(:exercise)
  }


  let(:invalid_attributes) {
    {name: ""}
  }


  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HypothesesController. Be sure to keep this updated too.
  let(:valid_session) { {
      user_id: 1
  } }

=begin
  describe "GET index" do
    it "assigns all hypothesis groups as @hypothesis_group" do
      hypothesis_goup = HypothesisGroup.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:hypothesis_group)).to eq([hypothesis_group])
    end
  end

  describe "GET show" do
    it "assigns the requested hypothesis group as @hypothesis_group" do
      hypothesis_group = HypothesisGroup.create! valid_attributes
      get :show, {:id => hypothesis_group.to_param}, valid_session
      expect(assigns(:hypothesis_group)).to eq(hypothesis_group)
    end
  end
=end

=begin
  describe "GET new" do
    it "assigns a new hypothesis group as @hypothesis_group" do
      get :new, {}, valid_session
      expect(assigns(:hypothesis_group)).to be_a_new(HypothesisGroup)
    end
  end
=end

=begin
  describe "GET edit" do
    it "assigns the requested hypothesis group as @hypothesis_group" do
      hypothesis_group = HypothesisGroup.create! valid_attributes
      get :edit, {:id => hypothesis_group.to_param}, valid_session
      expect(assigns(:hypothesis_group)).to eq(hypothesis_group)
    end
  end
=end

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
        expect(response).to redirect_to(hypotheses_path)
      end
    end


=begin
    describe "with invalid params" do
      it "assigns a newly created but unsaved hypothesis group as @hypothesis_group" do
        post :create, {:hypothesis_group => invalid_attributes}, valid_session
        expect(assigns(:hypothesis_group)).to be_a_new(HypothesisGroup)
      end


      it "re-renders the 'new' template" do
        post :create, {:hypothesis => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
=end

  end

=begin

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {name: "Virustauti"}
      }

      it "updates the requested hypothesis group" do
        hypothesis_group = HypothesisGroup.create! valid_attributes
        put :update, {:id => hypothesis_group.to_param, :hypothesis_group => new_attributes}, valid_session
        hypothesis_group.reload
        expect(hypothesis_group.name).to eq("Virustauti")
      end

      it "assigns the requested hypothesis group as @hypothesis_group" do
        hypothesis_group = HypothesisGroup.create! valid_attributes
        put :update, {:id => hypothesis_group.to_param, :hypothesis_group => valid_attributes}, valid_session
        expect(assigns(:hypothesis_group)).to eq(hypothesis_group)
      end

      it "redirects to the hypothesis group" do
        hypothesis_group = HypothesisGroup.create! valid_attributes
        put :update, {:id => hypothesis_group.to_param, :hypothesis_group => valid_attributes}, valid_session
        expect(response).to redirect_to(hypothesis_group)
      end
    end
=end

=begin
    describe "with invalid params" do
      it "assigns the hypothesis group as @hypothesis_group" do
        hypothesis_group = HypothesisGroup.create! valid_attributes
        put :update, {:id => hypothesis_group.to_param, :hypothesis_group => invalid_attributes}, valid_session
        expect(assigns(:hypothesis_group)).to eq(hypothesis_group)
      end

      it "re-renders the 'edit' template" do
        hypothesis_group = HypothesisGroup.create! valid_attributes
        put :update, {:id => hypothesis_group.to_param, :hypothesis_group => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
=end
  #end


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
      expect(response).to redirect_to(hypotheses_url)
    end
  end

end
