require 'rails_helper'

RSpec.describe MultichoicesController, :type => :controller do

	let!(:user){FactoryGirl.create(:user)}
	let!(:task){FactoryGirl.create(:task)}
	let!(:subtask){FactoryGirl.create(:subtask)}

	let(:valid_attributes) {
		{subtask_id: 1, question: "joku kysymys"}
	}

	let(:invalid_attributes) {
		{subtask_id: nil, question: nil}
	}

	let(:valid_session) { {
		user_id: 1, task_id: 1}
	}

	describe "GET new" do
		it "assigns a new multichoice as @multichoice" do
			get :new, {}, valid_session
			expect(assigns(:multichoice)).to be_a_new(Multichoice)
		end
	end

	describe "GET edit" do
		it "assigns the requested task as @task" do
			multichoice = Multichoice.create! valid_attributes
			get :edit, {:id => multichoice.to_param}, valid_session
			expect(assigns(:multichoice)).to eq(multichoice)
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

		end

		describe "POST create" do
			describe "with invalid params" do
				it "does not creates a new Multichoice" do
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
						put :update, {:id => multichoice.to_param, :multichoice => valid_attributes}, valid_session
						expect(assigns(:multichoice)).to eq(multichoice)
					end

					#it "redirects to the task" do
					#	multichoice = Multichoice.create! valid_attributes
					#	put :update, {:id => multichoice.to_param, :multichoice => valid_attributes}, valid_session
					#	expect(response).to redirect_to(edit_task_path(task.id))
					#end
				end

				describe "with invalid params" do
					let(:new_attributes) {
						{question: "Montako jalkaa lehmällä?"}
					}

					it "assigns the requested multichoice as @multichoice" do
						multichoice = Multichoice.create! valid_attributes
						put :update, {:id => multichoice.to_param, :multichoice => invalid_attributes}, valid_session
						expect(assigns(:multichoice)).to eq(multichoice)
					end
				end

			end

		end