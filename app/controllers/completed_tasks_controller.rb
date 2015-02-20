class CompletedTasksController < ApplicationController
  before_action :ensure_user_is_logged_in

  # POST /completed_tasks
  # POST /completed_tasks.json
  def create

    @completed_task = CompletedTask.new(completed_task_params)
    session[:task_id] = nil

    respond_to do |format|
      if @completed_task.save
        format.html { redirect_to tasks_url }
        format.json { render :show, status: :created, location: @completed_task }
      else
        format.html { redirect_to tasks_url, notice: "Toimenpiteen suoritus epäonnistui." }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def completed_task_params
    params.require(:completed_task).permit(:user_id, :task_id)
  end
end
