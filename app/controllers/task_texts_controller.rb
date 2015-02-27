class TaskTextsController < ApplicationController
 before_action :set_task_text, only: [:show, :edit, :update, :destroy]
 # before_action :ensure_user_is_logged_in
 # before_action :ensure_user_is_admin, except: [:index, :show]
  # GET /tasks
  # GET /tasks.json

  def show
  end

  # GET /task_texts/new
  def new
    @task_text = TaskText.new
  end

  # GET /tasks/1/edit
  def edit
    @task_text = TaskText.find(params[:id])
  end

  # POST /task_texts
  # POST /task_texts.json
  def create
    @task = Task.find(session[:task_id])

    # This can be done for each different type of subtask in their respective controllers
    subtask = @task.subtasks.create
    @task_text = subtask.create_task_text(content:task_text_params[:content])

    respond_to do |format|
      if @task_text.save
        format.html { redirect_to @task_text.subtask.task, notice: 'TaskText was successfully created.' }
        format.json { render :show, status: :created, location: @task_text }
      else
        # This is chewing gum
        @task_text.delete
        subtask.delete
        format.html { render :new }
        format.json { render json: @task_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_texts/1
  # PATCH/PUT /task_texts/1.json
  def update
    respond_to do |format|
      if @task_text.update(task_text_params)
        format.html { redirect_to edit_task_path(@task_text.subtask.task.id), notice: 'TaskText was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @task_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_texts/1
  # DELETE /task_texts/1.json
  def destroy
    @task_text.destroy
    respond_to do |format|
      format.html { redirect_to task_texts_url, notice: 'TaskText was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_text
      @task_text = TaskText.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_text_params
      params.require(:task_text).permit(:task_id, :content)
    end
end
