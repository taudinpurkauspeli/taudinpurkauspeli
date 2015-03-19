require 'rails_helper'

RSpec.describe TaskTextsController, :type => :controller do

  let!(:user){FactoryGirl.create(:user)}
  let!(:task){FactoryGirl.create(:task)}
  let!(:subtask){FactoryGirl.create(:subtask)}

  let(:valid_attributes) {
    {subtask_id: 1, content: "joku sisältö"}
  }

  let(:invalid_attributes) {
    {subtask_id: nil, content: nil}
  }

  let(:valid_session) { {
      user_id: 1, task_id: 1}
  }

  describe "GET new" do
    it "assigns a new task_text as @task_text" do
      get :new, {}, valid_session
      expect(assigns(:task_text)).to be_a_new(TaskText)
    end
  end

  describe "GET edit" do
    it "assigns the requested task as @task" do
      task_text = TaskText.create! valid_attributes
      get :edit, {:id => task_text.to_param}, valid_session
      expect(assigns(:task_text)).to eq(task_text)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Task_text" do
        expect {
          post :create, {:task_text => valid_attributes}, valid_session
        }.to change(TaskText, :count).by(1)
      end
    end

  end

  describe "POST create" do
    describe "with invalid params" do
      it "does not creates a new Task_text" do
        expect {
          post :create, {:task_text => invalid_attributes}, valid_session
        }.not_to change(TaskText, :count)
      end
    end

  end


  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {content: "Lehmällä on neljä jalkaa"}
      }

      it "assigns the requested task_text as @task_text" do
        task_text = TaskText.create! valid_attributes
        put :update, {:id => task_text.to_param, :task_text => valid_attributes}, valid_session
        expect(assigns(:task_text)).to eq(task_text)
      end

    end

  end

end