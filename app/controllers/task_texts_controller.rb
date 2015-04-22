class TaskTextsController < ApplicationController
  before_action :set_task_text, only: [:show, :edit, :update, :destroy, :check_answers]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:check_answers]

  # GET /tasks
  # GET /tasks.json
  def show
    set_view_layout
  end

  # GET /task_texts/new
  def new
    @task_text = TaskText.new

    set_view_layout
  end

  # GET /tasks/1/edit
  def edit
    set_view_layout
  end

  # POST /task_texts
  # POST /task_texts.json
  def create
    @task = Task.find(session[:task_id])

    # This can be done for each different type of subtask in their respective controllers
    subtask = @task.subtasks.build
    @task_text = subtask.build_task_text(content:task_text_params[:content])

    respond_to do |format|
      if @task_text.save
        subtask.save
        format.html { redirect_to edit_task_text_path(@task_text.id, :layout => get_layout), notice: 'Kysymys lisättiin onnistuneesti!' }
        format.json { render :show, status: :created, location: @task_text }
      else
        format.html { redirect_to edit_task_path(@task.id, :layout => get_layout), alert: 'Kysymyksen lisääminen epäonnistui!' }
        format.json { render json: @task_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_texts/1
  # PATCH/PUT /task_texts/1.json
  def update
    respond_to do |format|
      if @task_text.update(task_text_params)
        format.html { redirect_to edit_task_text_path(@task_text.id, :layout => get_layout), notice: 'Kysymys päivitettiin onnistuneesti!' }
      else
        format.html { redirect_to edit_task_text_path(@task_text.id, :layout => get_layout), alert: 'Kysymyksen päivitys epäonnistui!' }
        format.json { render json: @task_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # TODO fix user_has_completed redirect logic
  # /task_texts/:id/check_answers'
  def check_answers
    @task_text.user_answered_correctly?(current_user)
    respond_to do |format|
      if(current_user.has_completed?(current_exercise))
        format.html { redirect_to exercise_path(current_exercise, :layout => get_layout) }
      else
        format.html { redirect_to task_path(@task_text.subtask.task, :layout => get_layout), notice: 'Tehtävä suoritettu!' }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task_text
    @task_text = TaskText.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_text_params
    params.require(:task_text).permit(:content, :image_id)
  end
end
