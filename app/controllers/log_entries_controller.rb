class LogEntriesController < ApplicationController
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin
  before_action :set_log_entry, only: [:show, :destroy]

  # GET /log_entries
  def index
    @log_entries = LogEntry.all
    set_view_layout
  end

  # GET /log_entries/1
  def show

    @parameters = YAML::load(@log_entry.params)
    @exercise_hypothesis_ids = YAML::load(@log_entry.exhyp_ids)

    set_view_layout
  end

  # DELETE /log_entries/1
  def destroy
    @log_entry.destroy
    respond_to do |format|
      format.html { redirect_to log_entries_path(:layout => get_layout), notice: 'Lokin rivi poistettu.' }
    end
  end

  private
    def set_log_entry
      @log_entry = LogEntry.find(params[:id])
    end

    def log_entry_params
      params.require(:log_entry).permit(:user_id, :controller, :action, :params, :exercise_id, :task_id, :exhyp_ids, :datetime, :request_path, :ip, :method, :response_path)
    end
end
