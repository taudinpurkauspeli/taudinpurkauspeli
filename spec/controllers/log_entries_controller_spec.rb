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

RSpec.describe LogEntriesController, type: :controller do

  let!(:user){FactoryGirl.create(:user)}

  # This should return the minimal set of attributes required to create a valid
  # LogEntry. As you add validations to LogEntry, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {user_id: 2, controller: "exercises", action: "show", exercise_id: 2, method: "GET"}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LogEntriesController. Be sure to keep this updated too.
  let(:valid_session) { {user_id: user.id} }

  describe "GET #index" do
    it "assigns all log_entries as @log_entries" do
      log_entry = LogEntry.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:log_entries)).to eq([log_entry])
    end
  end

  describe "GET #show" do
    it "assigns the requested log_entry as @log_entry" do
      log_entry = LogEntry.create! valid_attributes
      get :show, {:id => log_entry.to_param}, valid_session
      expect(assigns(:log_entry)).to eq(log_entry)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested log_entry" do
      log_entry = LogEntry.create! valid_attributes
      expect {
        delete :destroy, {:id => log_entry.to_param}, valid_session
      }.to change(LogEntry, :count).by(-1)
    end

    it "redirects to the log_entries list" do
      log_entry = LogEntry.create! valid_attributes
      delete :destroy, {:id => log_entry.to_param}, valid_session
      expect(response).to redirect_to(log_entries_url)
    end
  end

end
