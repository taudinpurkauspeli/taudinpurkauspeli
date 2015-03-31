require 'rails_helper'

RSpec.describe MultichoicesController, :type => :controller do

	let!(:exercise){FactoryGirl.create(:exercise)}
	let!(:user){FactoryGirl.create(:user)}
	let!(:task){FactoryGirl.create(:task, exercise:exercise)}
	let!(:subtask){FactoryGirl.create(:subtask, task:task)}

	let(:valid_attributes) {
		{subtask_id: subtask.id, question: "joku kysymys"}
	}

	let(:invalid_attributes) {
		{subtask_id: nil, question: ""}
	}

	let(:valid_session) { {
			user_id: user.id, task_id: task.id}
	}

	describe "GET new" do
		it "assigns a new multichoice as @multichoice" do
			get :new, {}, valid_session
			expect(assigns(:multichoice)).to be_a_new(Multichoice)
		end
	end

	describe "GET edit" do
		it "assigns the requested multichoice as @multichoice" do
			multichoice = Multichoice.create! valid_attributes
			get :edit, {:id => multichoice.to_param}, valid_session
			expect(assigns(:multichoice)).to eq(multichoice)
		end
		it "assigns new option as @option" do
			multichoice = Multichoice.create! valid_attributes
			get :edit, {:id => multichoice.to_param}, valid_session
			expect(assigns(:new_option)).to be_a_new(Option)
		end
	end

	describe "POST create" do
		describe "with valid params" do
			it "creates a new Multichoice" do
				expect {
					post :create, {:multichoice => valid_attributes}, valid_session
				}.to change(Multichoice, :count).by(1)
			end
		end

		describe "with invalid params" do
			it "does not create a new Multichoice" do
				expect {
					post :create, {:multichoice => invalid_attributes}, valid_session
				}.not_to change(Multichoice, :count)
			end
		end

	end

	describe "PUT update" do
		describe "with valid params" do
			let(:new_attributes) {
				{question: "Montako jalkaa lehmällä?"}
			}

			it "assigns the requested multichoice as @multichoice" do
				multichoice = Multichoice.create! valid_attributes
				put :update, {:id => multichoice.to_param, :multichoice => new_attributes}, valid_session
				expect(assigns(:multichoice)).to eq(multichoice)
			end
		end

		describe "with invalid params" do

			it "assigns the requested multichoice as @multichoice" do
				multichoice = Multichoice.create! valid_attributes
				put :update, {:id => multichoice.to_param, :multichoice => invalid_attributes}, valid_session
				expect(assigns(:multichoice)).to eq(multichoice)
			end
		end

	end

end