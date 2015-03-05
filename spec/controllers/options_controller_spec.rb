require 'rails_helper'

RSpec.describe OptionsController, :type => :controller do

  let!(:user){FactoryGirl.create(:user)}
  let!(:task){FactoryGirl.create(:task)}
  let!(:multichoice){FactoryGirl.create(:multichoice)}

  let(:valid_attributes) {{content: "4 jalkaa", explanation: "Normaalilla lehmällä on kaksi etujalkaa ja kaksi takajalkaa",
  	value: true, multichoice_id: 1
  }}

  let(:invalid_attributes) {{content: nil, explanation: nil,
  	value: true, multichoice_id: nil}}

    let(:valid_session) { {
      user_id: 1, task_id: 1
  } }

    describe "GET edit" do
    it "assigns the requested option as @option" do
      option = Option.create! valid_attributes
      get :edit, {:id => option.to_param}, valid_session
      expect(assigns(:option)).to eq(option)
    end
  end


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

					#it "redirects to the task" do
					#	multichoice = Multichoice.create! valid_attributes
					#	put :update, {:id => multichoice.to_param, :multichoice => valid_attributes}, valid_session
					#	expect(response).to redirect_to(edit_task_path(task.id))
					#end
				end

			end

end
