class SubtasksController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin
  before_action :set_subtask, only: [:edit, :destroy, :move_down, :move_up]


  # GET /subtasks/1/edit
  def edit
    @subtask = Subtask.find(params[:id])
    if !@subtask.task_text.nil?
      redirect_to edit_task_text_path(@subtask.task_text.id, :layout => get_layout)
    elsif !@subtask.multichoice.nil?
      redirect_to edit_multichoice_path(@subtask.multichoice.id, :layout => get_layout)
    elsif !@subtask.interview.nil?
      redirect_to edit_interview_path(@subtask.interview.id, :layout => get_layout)
    elsif !@subtask.conclusion.nil?
      redirect_to edit_conclusion_path(@subtask.conclusion.id, :layout => get_layout)
    end
  end

  # DELETE /subtasks/1
  # DELETE /subtasks/1.json
  def destroy
    task_id = @subtask.task.id
    @subtask.update_levels_before_deleting
    @subtask.destroy
    respond_to do |format|
      format.html { redirect_to edit_task_path(task_id, :layout => get_layout), notice: 'Alakohta poistettu.' }
    end
  end

  def move_up
    @subtask.move_up(params[:new_level])
    respond_to do |format|
      format.html { redirect_to tasks_url(:layout => get_layout) }
      format.json { head :ok }
    end
  end

  def move_down
    @subtask.move_down(params[:new_level])
    respond_to do |format|
      format.html { redirect_to tasks_url(:layout => get_layout) }
      format.json { head :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_subtask
    @subtask = Subtask.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subtask_params
    params.require(:subtask).permit(:task_id, :task_text_id, :multichoice_id)
  end
end
