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
			user_id: 1}
	}

	describe "POST create" do
		describe "with valid params" do
			it "creates a new Multichoice" do
				expect {
					post :create, {:multichoice => valid_attributes}, valid_session
				}.to change(Multichoice, :count).by(1)
			end
		end

	end

end