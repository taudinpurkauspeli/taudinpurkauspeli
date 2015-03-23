class InterviewsController < ApplicationController
	before_action :ensure_user_is_logged_in
	before_action :ensure_user_is_admin, except: [:index, :show]
	before_action :set_interview, only: [:edit, :update, :destroy]


	def new
		@interview = Interview.new
	end

  # GET /interviews/1/edit
  def edit
  	@new_question = Question.new
  	@new_question_group = QuestionGroup.new
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

def update
	respond_to do |format|
		if @interview.update(interview_params)
			format.html { redirect_to edit_interview_path(@interview.id), notice: 'Haastattelu päivitettiin onnistuneesti.' }
		else
			@new_question = Question.new
			format.html { render :edit }
			format.json { render json: @interview.errors, status: :unprocessable_entity }
		end
	end
end

	def set_interview
		@interview = Interview.find(params[:id])
	end

	def interview_params
		params.require(:interview).permit(:title)

	end


end