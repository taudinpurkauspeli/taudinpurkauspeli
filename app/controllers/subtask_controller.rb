class SubtasksController < ApplicationController
 # before_action :set_task, only: [:show, :edit, :update, :destroy]
 # before_action :ensure_user_is_logged_in
 # before_action :ensure_user_is_admin, except: [:index, :show]
  # GET /tasks
  # GET /tasks.json

  def show
  end

  # GET /subtasks/new
  def new
    @subtask = Subtask.new
  end

  # GET /tasks/1/edit
  def edit
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
        format.html { render :new }
        format.json { render json: @subtask.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subtasks/1
  # PATCH/PUT /subtasks/1.json
  def update
    respond_to do |format|
      if @subtask.update(subtask_params)
        format.html { redirect_to @subtask, notice: 'Subtask was successfully updated.' }
        format.json { render :show, status: :ok, location: @subtask }
      else
        format.html { render :edit }
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
