class SubtasksController < ApplicationController
  before_action :set_subtask, only: [:show, :edit, :destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin
  # GET /tasks
  # GET /tasks.json

  def show
  end

  # GET /tasks/1/edit
  def edit

    @subtask = Subtask.find(params[:id])
    unless (@subtask.task_text.nil?)
      redirect_to edit_task_text_path(@subtask.task_text.id)
    end
    unless (@subtask.multichoice.nil?)
      redirect_to edit_multichoice_path(@subtask.multichoice.id)
    end

  end

  # POST /subtasks
  # POST /subtasks.json
  def create
    @subtask = Subtask.new(subtask_params)
    respond_to do |format|
      if @subtask.save
        format.html { redirect_to @subtask, notice: 'Subtask was successfully created.' }
        format.json { render :show, status: :created, location: @subtask }
      else
        format.html { redirect_to tasks_path }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subtasks/1
  # DELETE /subtasks/1.json
  def destroy
    @subtask.destroy
    respond_to do |format|
      format.html { redirect_to subtasks_url, notice: 'Subtask was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_subtask
    @subtask = Subtask.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subtask_params
    params.require(:subtask).permit(:task_id, :task_text_id)
  end
end
