class ExercisesController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in, except: [:index]
  before_action :ensure_user_is_admin, except: [:index, :show, :exercises_one, :restart_one]
  before_action :set_exercise, only: [:show, :edit, :update, :destroy, :duplicate_exercise, :toggle_hidden,
                                      :exercises_one, :update_one, :restart_one]
  before_action :set_current_user, only: [:show, :index, :restart_one]

  # GET /exercises
  # GET /exercises.json
  def index
    @exercises = Exercise.all.order(:name)
    @excercise_page_rendered = true
    session[:exercise_id] = nil
    session[:task_id] = nil
    session[:exhyp_ids] = nil

    respond_to do |format|
      format.html
      format.json { render json: @exercises }
    end
  end

  # GET /exercises_one/1
  # GET /exercises_one/1.json
  def exercises_one
    respond_to do |format|
      format.html
      format.json { render json: {exercise: @exercise, has_conclusion: @exercise.has_conclusion?} }
    end
  end

  # PATCH/PUT /exercises_one/1
  # PATCH/PUT /exercises_one/1.json
  def update_one
    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html { redirect_to exercise_path(@exercise.id, :layout => get_layout), notice: 'Casen päivitys onnistui!' }
        format.json { head :ok }
      else
        format.html { redirect_to exercise_path(@exercise.id, :layout => get_layout), alert: 'Casen päivitys epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end

  # PATCH/PUT /exercises_one/1/restart
  # PATCH/PUT /exercises_one/1/restart.json
  def restart_one
    respond_to do |format|
      if @exercise.restart(@current_user)
        format.html { redirect_to exercise_path(@exercise.id, :layout => get_layout), notice: 'Casen uudelleen aloittaminen onnistui!' }
        format.json { head :ok }
      else
        format.html { redirect_to exercise_path(@exercise.id, :layout => get_layout), alert: 'Casen uudelleen aloittaminen epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end

  # GET /exercises/1
  # GET /exercises/1.json
  def show
    session[:exercise_id] = params[:id]

    @completed_tasks = @current_user.tasks.includes(:completed_tasks).where("level > ?", 0).where(exercise:@exercise).order("completed_tasks.created_at")

    # Unchecked exercise hypotheses for conclusion view
    @conclusion_exercise_hypotheses = ExerciseHypothesis.where(id: session[:exhyp_ids])

  end

  # GET /exercises/new
  def new
    @exercise = Exercise.new
  end

  # GET /exercises/1/edit
  def edit
  end

  # POST /exercises
  # POST /exercises.json
  def create
    @exercise = Exercise.new(exercise_params)
    respond_to do |format|
      if @exercise.save
        format.html { redirect_to exercise_path(@exercise.id, :layout => get_layout), notice: 'Casen luominen onnistui!' }
        format.json { render json: @exercise }
      else
        format.html { redirect_to new_exercise_path(:layout => get_layout), alert: 'Casen luominen epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end

  # PATCH/PUT /exercises/1
  # PATCH/PUT /exercises/1.json
  def update
    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html { redirect_to exercise_path(@exercise.id, :layout => get_layout), notice: 'Casen päivitys onnistui!' }
        format.json { head :ok }
      else
        format.html { redirect_to exercise_path(@exercise.id, :layout => get_layout), alert: 'Casen päivitys epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.json
  def destroy
    @exercise.destroy
    respond_to do |format|
      format.html { redirect_to exercises_url, notice: 'Casen poistaminen onnistui!' }
      format.json { head :ok }
    end
  end

  def duplicate_exercise
    respond_to do |format|
      if @exercise.create_duplicate(@exercise)
        format.html { redirect_to exercises_path(:layout => get_layout), notice: 'Casen kopioiminen onnistui!' }
        format.json { head :ok }
      else
        format.html { redirect_to exercises_path(:layout => get_layout), notice: 'Casen kopioiminen epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end

  def toggle_hidden
    respond_to do |format|
      if @exercise.update(hidden:!@exercise.hidden?)
        format.html { redirect_to exercises_path(:layout => get_layout), notice: 'Casen näkyvyys muutettu.' }
      else
        format.html { redirect_to exercises_path(:layout => get_layout), notice: 'Casen näkyvyyttä ei voi muuttaa.' }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def exercise_params
    params.require(:exercise).permit(:name, :anamnesis, :hidden)

  end
end
