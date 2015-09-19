class LogEntriesController < ApplicationController
  before_action :set_log_entry, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @log_entries = LogEntry.all
    respond_with(@log_entries)
  end

  def show
    respond_with(@log_entry)
  end

  def new
    @log_entry = LogEntry.new
    respond_with(@log_entry)
  end

  def edit
  end

  def create
    @log_entry = LogEntry.new(log_entry_params)
    @log_entry.save
    respond_with(@log_entry)
  end

  def update
    @log_entry.update(log_entry_params)
    respond_with(@log_entry)
  end

  def destroy
    @log_entry.destroy
    respond_with(@log_entry)
  end

  private
    def set_log_entry
      @log_entry = LogEntry.find(params[:id])
    end

    def log_entry_params
      params.require(:log_entry).permit(:user_id, :controller, :action, :params, :exercise_id, :task_id, :exhyp_ids, :datetime, :request_path, :ip, :method, :response_path)
    end
end
