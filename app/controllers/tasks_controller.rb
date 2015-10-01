class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :show, :level_up, :level_down]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :show]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
    @user = current_user
    @last_clicked_task_id = params[:last_clicked_task_id]

    @exercise = current_exercise
    if @exercise
      if current_user.try(:admin)
        @tasks = @exercise.tasks.where("level > ?", 0).order("level")
      else
        @completed_tasks = @user.tasks.where("level > ?", 0).where(exercise:@exercise).order("level")
        @available_tasks = @exercise.tasks.where("level > ?", 0).order("name") - @completed_tasks
      end
    else
      redirect_to exercises_path, alert: 'Valitse ensin case, jota haluat tarkastella!'
    end

    set_view_layout
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show

    unless params[:last_clicked_conclusion].nil?
      @last_clicked_conclusion = ExerciseHypothesis.find(params[:last_clicked_conclusion])
    end

    unless current_user.try(:admin)
      if current_user.can_start?(@task)
        session[:task_id] = params[:id]
      else
        respond_to do |format|
          format.html { redirect_to tasks_url(:layout => get_layout, :last_clicked_task_id => params[:id]), alert: 'Et voi vielä suorittaa tätä toimenpidettä, vaan sinun tulee suorittaa ainakin yksi muu toimenpide ennen tätä.' and return }
        end
      end
    else
      @task = Task.find(params[:id])
    end

    @multichoice_checked_options = params[:multichoice_checked_options].to_a
    @last_clicked_question_id = params[:last_clicked_question_id]

    @subtasks = @task.subtasks

    @new_completed_task = CompletedTask.new
    @new_asked_question = AskedQuestion.new
    @exercise_hypotheses = ExerciseHypothesis.where(exercise: @task.exercise)

    # Unchecked exercise hypothesis id:s to session
    unless @task.conclusions.empty?
      if session[:exhyp_ids].nil?
        session[:exhyp_ids] = (@exercise_hypotheses - current_user.exercise_hypotheses).map(&:id)
      end
    end

    # Unchecked exercise hypotheses for conclusion view
    @conclusion_exercise_hypotheses = ExerciseHypothesis.where(id: session[:exhyp_ids])

    set_view_layout

  end

  # GET /tasks/new
  def new
    @task = Task.new

    set_view_layout
  end

  # GET /tasks/1/edit
  def edit
    session[:task_id] = params[:id]
    @subtasks = @task.subtasks

    set_view_layout
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.exercise_id = session[:exercise_id]
    @task.level = Task.get_highest_level(@task.exercise) + 1

    respond_to do |format|
      if @task.save
        format.html { redirect_to edit_task_path(@task.id, :layout => get_layout), notice: 'Toimenpide luotiin onnistuneesti.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { redirect_to new_task_path(:layout => get_layout), alert: 'Toimenpiteen luonti epäonnistui.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to edit_task_path(@task.id, :layout => get_layout), notice: 'Toimenpide päivitettiin onnistuneesti.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { redirect_to edit_task_path(@task.id, :layout => get_layout), alert: 'Toimenpiteen päivitys epäonnistui.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.reset_prerequisites
    session[:task_id] = nil
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url(:layout => get_layout), notice: 'Toimenpide poistettu.' }
      format.json { head :no_content }
    end
  end

  def level_up
    @task.move_up
    respond_to do |format|
      format.html { redirect_to tasks_url(:layout => get_layout) }
    end
  end

  def level_down
    @task.move_down
    respond_to do |format|
      format.html { redirect_to tasks_url(:layout => get_layout) }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:name)
  end
end
