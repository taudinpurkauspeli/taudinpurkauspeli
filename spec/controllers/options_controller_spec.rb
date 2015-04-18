require 'rails_helper'

RSpec.describe OptionsController, :type => :controller do

	let!(:user){FactoryGirl.create(:user)}
	let!(:task){FactoryGirl.create(:task)}
	let!(:multichoice){FactoryGirl.create(:multichoice)}

	let(:valid_attributes) {{content: "4 jalkaa", explanation: "Normaalilla lehmällä on kaksi etujalkaa ja kaksi takajalkaa",
													 is_correct_answer: "required", multichoice_id: 1
	}}

	let(:invalid_attributes) {{content: nil, explanation: nil, multichoice_id: 1}}

	let(:valid_session) { {
			user_id: 1, task_id: 1
	} }

	describe "POST create" do
		describe "with valid params" do
			it "creates a new Option" do
				expect {
					post :create, {:option => valid_attributes}, valid_session
				}.to change(Option, :count).by(1)
			end
		end

	end

	describe "POST create" do
		describe "with invalid params" do
			it "does not create a new Option" do
				expect {
					post :create, {:option => invalid_attributes}, valid_session
				}.not_to change(Option, :count)
			end
		end

	end

	describe "PUT update" do
		describe "with valid params" do
			let(:new_attributes) {
				{content: "Lehmällä on 4 jalkaa", explanation: "Jos käyt laitumelta katsomassa niin huomaat että useimmilla lehmillä on 4 jalkaa."}
			}

			it "assigns the requested option as @option" do
				option = Option.create! valid_attributes
				put :update, {:id => option.to_param, :option => valid_attributes}, valid_session
				expect(assigns(:option)).to eq(option)
			end

		end

		describe "with invalid params" do
			let(:new_attributes) {
				{content: "Lehmällä on 4 jalkaa", explanation: "Jos käyt laitumelta katsomassa niin huomaat että useimmilla lehmillä on 4 jalkaa."}
			}

			it "assigns the requested option as @option" do
				option = Option.create! valid_attributes
				put :update, {:id => option.to_param, :option => invalid_attributes}, valid_session
				expect(assigns(:option)).to eq(option)
			end

		end

	end

	describe "DELETE destroy" do
		it "destroys the requested option" do
			option = Option.create! valid_attributes
			expect {
				delete :destroy, {:id => option.to_param}, valid_session
			}.to change(Option, :count).by(-1)
		end

		it "redirects to the multichoice edit" do
			option = Option.create! valid_attributes
			delete :destroy, {:id => option.to_param}, valid_session
			expect(response).to redirect_to(edit_multichoice_path(:layout => true))
		end
	end

end
