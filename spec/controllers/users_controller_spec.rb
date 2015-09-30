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

RSpec.describe UsersController, :type => :controller do

  let!(:admin_user){FactoryGirl.create(:user)}
  let!(:normal_user){FactoryGirl.create(:student)}
  let!(:normal_user2){FactoryGirl.create(:student, username: "Teppo", first_name: "Töppö", last_name: "Tippo", student_number:"000000002")}
  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {username: "Pekka", email: "kukkuu@kukkuu.com", admin: true, first_name: "Pekka", last_name: "Topohanta", password: "Salasana1", password_confirmation: "Salasana1", student_number: "000000003", starting_year: 2000}

  }

  let(:invalid_attributes) {
    {username: "", first_name: "", last_name: "", password: "Salasana1", password_confirmation: "Salasana1", email: ""}

  }

  # This should return the minimal set of values that should be in the session

  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_admin_session) { {
      user_id: 1
  } }

  let(:valid_normal_session) { {
      user_id: 2
  } }

  describe "GET index" do
    describe "for admin" do
      it "assigns all normal users as @users" do
        get :index, {}, valid_admin_session
        expect(assigns(:users)).to eq([normal_user, normal_user2])
      end
    end

    describe "for normal user" do
      it "redirects to exercises page" do
        get :index, {}, valid_normal_session
        expect(response).to redirect_to(exercises_path)
      end
    end
  end

  describe "GET show" do

    describe "for admin" do
      it "assigns the requested user as @user for own show page" do
        get :show, {:id => admin_user.to_param}, valid_admin_session
        expect(assigns(:user)).to eq(admin_user)
      end

      it "assigns the requested user as @user for student show page" do
        get :show, {:id => normal_user.to_param}, valid_admin_session
        expect(assigns(:user)).to eq(normal_user)
      end
    end

    describe "for normal user" do
      it "assigns the requested user as @user in own page" do
        get :show, {:id => normal_user.to_param}, valid_normal_session
        expect(assigns(:user)).to eq(normal_user)
      end

      it "redirects to exercises page in other user's page" do
        get :show, {:id => normal_user2.to_param}, valid_normal_session
        expect(response).to redirect_to(exercises_path)
      end
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new, {}, valid_normal_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET edit" do

    describe "for admin" do
      it "assigns the requested user as @user for own edit page" do
        get :edit, {:id => admin_user.to_param}, valid_admin_session
        expect(assigns(:user)).to eq(admin_user)
      end
      it "assigns the requested user as @user for student edit page" do
        get :edit, {:id => normal_user.to_param}, valid_admin_session
        expect(assigns(:user)).to eq(normal_user)
      end
    end

    describe "for normal user" do
      it "assigns the requested user as @user in own page" do
        get :edit, {:id => normal_user.to_param}, valid_normal_session
        expect(assigns(:user)).to eq(normal_user)
      end

      it "redirects to exercises page in other user's page" do
        get :edit, {:id => normal_user2.to_param}, valid_normal_session
        expect(response).to redirect_to(exercises_path)
      end
    end

  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {:user => valid_attributes}, valid_normal_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}, valid_normal_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the root page" do
        post :create, {:user => valid_attributes}, valid_normal_session
        expect(response).to redirect_to(:root)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, {:user => invalid_attributes}, valid_normal_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, {:user => invalid_attributes}, valid_normal_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_admin_attributes) {
        {username: "Topohanta", email: "kukkuu@kukkuu.com", admin: true, first_name: "Pekka", last_name: "Topohanta", password: "Salasana1", password_confirmation: "Salasana1", student_number: "000000011", starting_year: 2000}
      }

      let(:new_normal_attributes) {
        {username: "Topohanta", email: "kukkuu@kukkuu.com", admin: false, first_name: "Pekka", last_name: "Topohanta", password: "Salasana1", password_confirmation: "Salasana1", student_number: "000000010", starting_year: 2000}
      }

      describe "for admin" do

        it "updates own information" do
          put :update, {:id => admin_user.to_param, :user => new_admin_attributes}, valid_admin_session
          admin_user.reload
          expect(admin_user.username).to eq("Topohanta")
          expect(admin_user.first_name).to eq("Pekka")
        end

        it "updates student information" do
          put :update, {:id => normal_user.to_param, :user => new_normal_attributes}, valid_admin_session
          normal_user.reload
          expect(normal_user.username).to eq("Topohanta")
          expect(normal_user.first_name).to eq("Pekka")
        end

        it "assigns the requested normal user as @user" do
          put :update, {:id => normal_user.to_param, :user => new_normal_attributes}, valid_admin_session
          expect(assigns(:user)).to eq(normal_user)
        end

        it "assigns the requested admin user as @user" do
          put :update, {:id => admin_user.to_param, :user => new_admin_attributes}, valid_admin_session
          expect(assigns(:user)).to eq(admin_user)
        end

        it "redirects to the user" do
          put :update, {:id => admin_user.to_param, :user => new_admin_attributes}, valid_admin_session
          expect(response).to redirect_to(admin_user)
        end
      end

      describe "for normal user" do

        it "updates own information" do
          put :update, {:id => normal_user.to_param, :user => new_normal_attributes}, valid_normal_session
          normal_user.reload
          expect(normal_user.username).to eq("Topohanta")
          expect(normal_user.first_name).to eq("Pekka")
        end

        it "does not update other student's information" do
          put :update, {:id => normal_user2.to_param, :user => new_normal_attributes}, valid_normal_session
          expect(response).to redirect_to(exercises_path)
        end

        it "assigns the requested normal user as @user" do
          put :update, {:id => normal_user.to_param, :user => new_normal_attributes}, valid_normal_session
          expect(assigns(:user)).to eq(normal_user)
        end

        it "redirects to the user" do
          put :update, {:id => normal_user.to_param, :user => new_normal_attributes}, valid_normal_session
          expect(response).to redirect_to(normal_user)
        end
      end
    end

    describe "with invalid params" do


      describe "for admin" do

        it "does not update own information" do
          put :update, {:id => admin_user.to_param, :user => invalid_attributes}, valid_admin_session
          admin_user.reload
          expect(admin_user.username).to eq("Testipoika")
          expect(admin_user.first_name).to eq("Teppo")
          expect(admin_user.last_name).to eq("Testailija")
        end

        it "does not update student information" do
          put :update, {:id => normal_user.to_param, :user => invalid_attributes}, valid_admin_session
          normal_user.reload
          expect(normal_user.username).to eq("Opiskelija")
          expect(normal_user.first_name).to eq("Olli")
          expect(normal_user.last_name).to eq("Testailija")
        end

        it "assigns the requested normal user as @user" do
          put :update, {:id => normal_user.to_param, :user => invalid_attributes}, valid_admin_session
          expect(assigns(:user)).to eq(normal_user)
        end

        it "assigns the requested admin user as @user" do
          put :update, {:id => admin_user.to_param, :user => invalid_attributes}, valid_admin_session
          expect(assigns(:user)).to eq(admin_user)
        end

        it "re-renders the 'edit' template" do
          put :update, {:id => admin_user.to_param, :user => invalid_attributes}, valid_admin_session
          expect(response).to render_template("edit")
        end
      end

      describe "for normal user" do

        it "does not update own information" do
          put :update, {:id => normal_user.to_param, :user => invalid_attributes}, valid_normal_session
          normal_user.reload
          expect(normal_user.username).to eq("Opiskelija")
          expect(normal_user.first_name).to eq("Olli")
          expect(normal_user.last_name).to eq("Testailija")
        end

        it "does not update other student's information" do
          put :update, {:id => normal_user2.to_param, :user => invalid_attributes}, valid_normal_session
          expect(response).to redirect_to(exercises_path)
        end

        it "assigns the requested normal user as @user" do
          put :update, {:id => normal_user.to_param, :user => invalid_attributes}, valid_normal_session
          expect(assigns(:user)).to eq(normal_user)
        end

        it "redirects to the user" do
          put :update, {:id => normal_user.to_param, :user => invalid_attributes}, valid_normal_session
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do

    describe "for admin" do
      it "destroys the requested normal user" do
        expect {
          delete :destroy, {:id => normal_user.to_param}, valid_admin_session
        }.to change(User, :count).by(-1)
      end

      it "destroys own account" do
        expect {
          delete :destroy, {:id => admin_user.to_param}, valid_admin_session
        }.to change(User, :count).by(-1)
      end

      it "redirects to the starting page" do
        delete :destroy, {:id => admin_user.to_param}, valid_admin_session
        expect(response).to redirect_to(:root)
      end

    end

    describe "for normal user" do
      it "does not destoy other user's account" do
        expect {
          delete :destroy, {:id => normal_user2.to_param}, valid_normal_session
        }.to change(User, :count).by(0)
      end

      it "destroys own account" do
        expect {
          delete :destroy, {:id => normal_user.to_param}, valid_normal_session
        }.to change(User, :count).by(-1)
      end

      it "redirects to the starting page" do
        delete :destroy, {:id => normal_user.to_param}, valid_normal_session
        expect(response).to redirect_to(:root)
      end
    end
  end

end
