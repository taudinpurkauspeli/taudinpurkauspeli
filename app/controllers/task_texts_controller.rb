class TaskTextsController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:check_answers]
  before_action :set_task_text, only: [:edit, :update, :destroy, :check_answers, :show]
  before_action :set_current_user, only: [:check_answers]

  # GET /task_texts/new
  def new
    @task_text = TaskText.new

  end

  # GET /task_texts/1/edit
  def edit
  end

  # GET /task_texts/1
  def show
    respond_to do |format|
      format.html
      format.json { render json: @task_text }
    end
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
      else
        format.html { redirect_to edit_task_path(@task.id, :layout => get_layout), alert: 'Kysymyksen lisääminen epäonnistui!' }
      end
    end
  end

  # POST /task_texts_json_create
  # POST /task_texts_json_create.json
  def json_create
    @task = Task.find(params[:task_id])

    # This can be done for each different type of subtask in their respective controllers
    subtask = @task.subtasks.build
    @task_text = subtask.build_task_text(content:task_text_params[:content])

    respond_to do |format|
      if @task_text.save
        subtask.save
        format.html { redirect_to edit_task_text_path(@task_text.id, :layout => get_layout), notice: 'Kysymys lisättiin onnistuneesti!' }
        format.json { render json: @task_text }
      else
        format.html { redirect_to edit_task_path(@task.id, :layout => get_layout), alert: 'Kysymyksen lisääminen epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end

  end

  # PATCH/PUT /task_texts/1
  # PATCH/PUT /task_texts/1.json
  def update
    respond_to do |format|
      if @task_text.update(task_text_params)
        format.html { redirect_to edit_task_text_path(@task_text.id, :layout => get_layout), notice: 'Kysymys päivitettiin onnistuneesti!' }
        format.json { head :ok }
      else
        format.html { redirect_to edit_task_text_path(@task_text.id, :layout => get_layout), alert: 'Kysymyksen päivitys epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end

  # DELETE /task_texts/1
  # DELETE /task_texts/1.json
  def destroy
    @task_text.subtask.update_levels_before_deleting
    @task_text.subtask.destroy
    respond_to do |format|
      format.html
      format.json { head :ok }
    end
  end

  # TODO fix user_has_completed redirect logic
  # /task_texts/:id/check_answers
  def check_answers
    @task_text.user_answered_correctly?(@current_user)
    respond_to do |format|
      if @current_user.has_completed?(current_exercise)
        format.html { redirect_to task_path(@task_text.subtask.task, :layout => get_layout, notice: "Onneksi olkoon suoritit casen!") }
        format.json { head :accepted }
      else
        format.html { redirect_to task_path(@task_text.subtask.task, :layout => get_layout), notice: 'Tehtävä suoritettu!' }
        format.json { head :ok }
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
    params.require(:task_text).permit(:content, :task_id)
  end
end
