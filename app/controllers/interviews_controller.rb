class InterviewsController < ApplicationController
	before_action :ensure_user_is_logged_in
	before_action :ensure_user_is_admin, except: [:index, :show, :ask_question, :check_answers]
	before_action :set_interview, only: [:edit, :update, :destroy, :ask_question, :check_answers]

	def new
		@interview = Interview.new

		set_view_layout
	end

	# GET /interviews/1/edit
	def edit
		@new_question = Question.new
		@new_asked_question = AskedQuestion.new
		@new_question_group = QuestionGroup.new
		@question_groups = QuestionGroup.all

		set_view_layout
	end


	def create
		@task = Task.find(session[:task_id])

		# This can be done for each different type of subtask in their respective controllers
		subtask = @task.subtasks.build
		@interview = subtask.build_interview(title:interview_params[:title])

		respond_to do |format|
			if @interview.save
				subtask.save
				format.html { redirect_to edit_interview_path(@interview.id, :layout => get_layout), notice: 'Haastattelu lisättiin onnistuneesti.' }
				#format.json { render :show, status: :created, location: @multichoice }
			else
				## TODO redirect task show
				format.html { redirect_to new_interview_path(:layout => get_layout), alert: 'Haastattelun lisääminen epäonnistui.' }
				format.json { render json: @interview.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @interview.update(interview_params)
				format.html { redirect_to edit_interview_path(@interview.id, :layout => get_layout), notice: 'Haastattelu päivitettiin onnistuneesti.' }
			else
				@new_question = Question.new
				format.html { redirect_to edit_interview_path(@interview.id, :layout => get_layout), alert: 'Haastattelun päivitys epäonnistui.' }
				format.json { render json: @interview.errors, status: :unprocessable_entity }
			end
		end
	end

	def ask_question
		current_user.ask_question(Question.find(question_params[:question_id]))

		respond_to do |format|
			format.html { redirect_to task_path(@interview.subtask.task, :layout => get_layout) }
		end
	end

	def check_answers
		respond_to do |format|
			if current_user.has_asked_all_required_questions_of(@interview)
				current_user.complete_subtask(@interview.subtask)
				format.html { redirect_to task_path(@interview.subtask.task, :layout => get_layout) }
			else
				format.html { redirect_to task_path(@interview.subtask.task, :layout => get_layout), alert: 'Et ole vielä valinnut kaikki tarpeellisia vaihtoehtoja!' }
			end
		end
	end

	private
	def set_interview
		@interview = Interview.find(params[:id])
	end

	def question_params
		params.permit(:question_id)
	end

	def interview_params
		params.require(:interview).permit(:title)
	end
end