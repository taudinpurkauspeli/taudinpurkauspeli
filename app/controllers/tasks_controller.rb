class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :show, :level_up, :level_down]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :show]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all

    @exercise = current_exercise
    if @exercise
      if current_user_is_admin
        @tasks = @exercise.tasks.order("level")
      else
        @tasks = @exercise.tasks.order("name")
      end
    else
      redirect_to exercises_path, alert: 'Valitse ensin case, jota haluat tarkastella!'
    end

    if params[:layout] === "false"
      render :layout => false
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show

    unless current_user_is_admin
      if user_can_start_task(current_user, current_exercise, @task.level)
        session[:task_id] = params[:id]
      else
        respond_to do |format|
          format.html { redirect_to tasks_url, alert: 'Et voi vielä suorittaa tätä toimenpidettä.' }
        end
      end
    else
      @task = Task.find(params[:id])
    end

    @subtasks = @task.subtasks
    @new_completed_task = CompletedTask.new

    if params[:layout] === "false"
      render :layout => false
    end
  end

  def user_can_start_task(user, exercise, level)  
    return user.get_number_of_tasks_by_level(exercise, level - 1) == exercise.get_number_of_tasks_by_level(level - 1)
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    session[:task_id] = params[:id]
    @subtasks = @task.subtasks

    if params[:layout] === "false"
      render :layout => false
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.exercise_id = session[:exercise_id]
    @task.level = Task.get_highest_level(@task.exercise) + 1

    respond_to do |format|
      if @task.save
        format.html { redirect_to edit_task_path(@task.id), notice: 'Toimenpide luotiin onnistuneesti.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        if params[:layout] === "false"
          format.html { redirect_to edit_task_path(@task.id, :layout => false), notice: 'Toimenpide päivitettiin onnistuneesti.' }
        else
          format.html { redirect_to edit_task_path(@task.id), notice: 'Toimenpide päivitettiin onnistuneesti.' }
        end  
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    session[:task_id] = nil
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def level_up
    @task.move_up
    respond_to do |format|
      if params[:layout] === "false"
        format.html { redirect_to tasks_url(:layout => false) }
      else
        format.html { redirect_to tasks_url }
      end    
    end
  end

  def level_down
    @task.move_down
    respond_to do |format|
      if params[:layout] === "false"
        format.html { redirect_to tasks_url(:layout => false) }
      else
        format.html { redirect_to tasks_url }
      end      
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
