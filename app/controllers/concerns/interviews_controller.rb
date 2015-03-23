class InterviewsController < ApplicationController
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :show]
  before_action :set_multichoice, only: [:edit, :update, :destroy]


  def new
    @interview = Interview.new
  end

  # GET /multichoices/1/edit
  def edit
  end


  def create
    @task = Task.find(session[:task_id])

    # This can be done for each different type of subtask in their respective controllers
    subtask = @task.subtasks.build
    @interview = subtask.build_interview(title:interview_params[:title])

    respond_to do |format|
      if @interview.save
        subtask.save
        format.html { redirect_to edit_interview_path(@interview.id), notice: 'Haastattelu lisättiin onnistuneesti.' }
        #format.json { render :show, status: :created, location: @multichoice }
      else
        format.html { render :new }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

   def set_multichoice
    @interview = Interview.find(params[:id])
  end

  def interview_params
    params.require(:interview).permit(:title)

  end


end