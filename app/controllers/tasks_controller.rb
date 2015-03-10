class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :show]
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show

    unless current_user_is_admin
      if current_user.get_level(current_exercise) + 1 >= @task.level
      session[:task_id] = params[:id]
      @task = current_task

      else
        format.html { redirect_to tasks_url, notice: 'Et voi vielä suorittaa tätä toimenpidettä.' }
      end
    else
      @task = Task.find(params[:id])
    end

    @subtasks = @task.subtasks

    #new instances
    @new_completed_task = CompletedTask.new
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    session[:task_id] = params[:id]
    @subtasks = @task.subtasks
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.level = Task.find_highest_level + 1
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
        format.html { redirect_to edit_task_path(@task.id), notice: 'Toimenpide päivitettiin onnistuneesti.' }
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
