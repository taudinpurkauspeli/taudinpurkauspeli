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

RSpec.describe TasksController, :type => :controller do

  let!(:user){FactoryGirl.create(:user)}
  let!(:exercise){FactoryGirl.create(:exercise)}
  # This should return the minimal set of attributes required to create a valid
  # Task. As you add validations to Task, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {name: "Soita asiakkaalle", exercise: exercise, level:1}
  }


  let(:invalid_attributes) {
    {name: nil, exercise_id: exercise.id}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TasksController. Be sure to keep this updated too.
  let(:valid_session) { {
      user_id: user.id, exercise_id: exercise.id
  } }

  let(:tasktext_attributes) {
    {content: "Sisältöä" }
  }

  let(:multichoice_attributes) {
    {question: "Tykkääkö koira snabbuloist?" }
  }


  describe "GET index" do
    it "assigns all tasks as @tasks" do
      task = Task.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:tasks)).to eq([task])
    end
  end

  describe "GET show" do
    it "assigns the requested task as @task" do
      task = Task.create! valid_attributes
      FactoryGirl.create(:subtask, task_id: 2)
      FactoryGirl.create(:task_text, subtask_id: 1)
      get :show, {:id => task.to_param}, valid_session
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "GET new" do
    it "assigns a new task as @task" do
      get :new, {}, valid_session
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe "GET edit" do
    it "assigns the requested task as @task" do
      task = Task.create! valid_attributes
      get :edit, {:id => task.to_param}, valid_session
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns correct level" do
        for i in 1..5
          new_valid_attributes = {name: "Soita asiakkaalle" + i.to_s, exercise_id: exercise.id, level: 2}
          post :create, {:task => new_valid_attributes}, valid_session
        end
        expect(Task.get_highest_level(exercise)).to eq(5)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved task as @task" do
        post :create, {:task => invalid_attributes}, valid_session
        expect(assigns(:task)).to be_a_new(Task)
      end

      it "redirects to the task list" do
        post :create, {:task => invalid_attributes}, valid_session
        expect(response).to redirect_to(new_task_path(:layout => true))
      end
    end
  end


  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {name: "Soita asiakkaalle uudestaan"}
      }

=begin
      it "updates the requested task" do
        task = Task.create! valid_attributes
        put :update, {:id => task.to_param, :task => new_attributes}, valid_session
        task.reload
        expect(task.name).to eq("Soita asiakkaalle uudestaan")
      end
=end

      it "assigns the requested task as @task" do
        task = Task.create! valid_attributes
        put :update, {:id => task.to_param, :task => valid_attributes}, valid_session
        expect(assigns(:task)).to eq(task)
      end

      it "redirects to the task" do
        task = Task.create! valid_attributes
        put :update, {:id => task.to_param, :task => valid_attributes}, valid_session
        expect(response).to redirect_to(edit_task_path(task.id, :layout => true))
      end
    end

    describe "POST level_up" do


      let!(:task2){FactoryGirl.create(:task, exercise:exercise, level: 1)}
      let!(:task3){FactoryGirl.create(:task, name: "Soita lääkärille", exercise:exercise, level: 2)}

      it "changes the level when no siblings & no children" do

        expect {
          post :level_up, {:id => task3.id}, valid_session
        }.to change{Task.last.level}.by(-1)

      end

    end

=begin
    describe "with invalid params" do
      it "assigns the task as @task" do
        task = Task.create! valid_attributes
        put :update, {:id => task.to_param, :task => invalid_attributes}, valid_session
        expect(assigns(:task)).to eq(task)
      end

      it "re-renders the 'edit' template" do
        task = Task.create! valid_attributes
        put :update, {:id => task.to_param, :task => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
=end
  end


  describe "DELETE destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete :destroy, {:id => task.to_param}, valid_session
      }.to change(Task, :count).by(-1)
    end

    #kuormitin subtaskia ja tämä toimii, vaikka ei periaatteessa pitäisi
    it "destroys the requested tasks subtasks" do
      task = Task.create! valid_attributes
      subtask = task.subtasks.create
      task_text = subtask.create_task_text(content:tasktext_attributes[:content])
      multichoice = subtask.create_multichoice(question:multichoice_attributes[:question])

      expect {    delete :destroy, {:id => task.to_param}, valid_session
      }.to change(task.subtasks, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete :destroy, {:id => task.to_param}, valid_session
      expect(response).to redirect_to(tasks_url(:layout => true))
    end
  end

end
