class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_is_logged_in, except: [:new, :create]
  before_action :ensure_user_is_admin, only: [:index]
  before_action except: [:new, :create, :index] do
    if @user.nil? || (!current_user.try(:admin) && @user != current_user)
      redirect_to exercises_path, alert: 'Pääsy toisen käyttäjän tietoihin estetty!'
    end
  end

  # GET /users
  # GET /users.json
  def index
      @exercises = Exercise.all
      @users = User.where("admin = ?", false)

      #list type
      if params[:list_type].nil? || params[:list_type] == "0"
        @list_type = 0
      else
        @list_type = 1
      end


      #exercise
      if params[:exercise].nil? || params[:exercise] == "0"
        @shown_exercises = @exercises
        @selected_exercise_id = "0"
      else
        @shown_exercises  = Exercise.where("id = ?", params[:exercise])
        @selected_exercise_id = params[:exercise]
      end

      #starting year
      if params[:starting_year].nil? || params[:starting_year] == "0"
        @shown_users = @users
        @selected_starting_year = "0"
      else
        @shown_users  = User.where("starting_year = ? and admin = ?", params[:starting_year].to_i, false)
        @selected_starting_year = params[:starting_year]
      end
  end

  # GET /users/1
  # GET /users/1.json
  def show
      @exercises = Exercise.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        @user.authenticate(user_params[:password])
        session[:user_id] = @user.id
        format.html { redirect_to :root, notice: 'Käyttäjätunnuksen luominen onnistui!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    unless @user.nil?
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'Käyttäjän tiedot päivitetty.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    unless @user.nil?

      @user.destroy
      session[:user_id] = nil
      session[:exercise_id] = nil
      session[:task_id] = nil
      session[:exhyp_id] = nil

      respond_to do |format|
        format.html { redirect_to :root, notice: 'Käyttäjä poistettu.' }
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(id:params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :realname, :email, :admin, :password, :password_confirmation, :student_number, :starting_year)
  end

end
