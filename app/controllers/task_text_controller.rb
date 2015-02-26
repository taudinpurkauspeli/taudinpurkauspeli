class TextTasksController < ApplicationController
 # before_action :set_task, only: [:show, :edit, :update, :destroy]
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
  end

  # POST /task_texts
  # POST /task_texts.json
  def create
    @task_text = TaskText.new(task_text_params)
    respond_to do |format|
      if @task_text.save
        format.html { redirect_to @task_text, notice: 'TaskText was successfully created.' }
        format.json { render :show, status: :created, location: @task_text }
      else
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
        format.html { redirect_to @task_text, notice: 'TaskText was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_text }
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
