class ConclusionsController < ApplicationController
	protect_from_forgery
	skip_before_action :verify_authenticity_token, if: :json_request?

	before_action :ensure_user_is_logged_in
	before_action :ensure_user_is_admin, except: [:check_answers]
	before_action :set_conclusion, only: [:edit, :update, :check_answers, :destroy, :json_update, :json_destroy]
	before_action :set_current_user, only: [:check_answers]

	def new
		@hypothesis_groups = HypothesisGroup.all
		@exercise_hypotheses = ExerciseHypothesis.where(exercise: current_exercise)
		@conclusion = Conclusion.new
		set_view_layout
	end

	# GET /conclusions/1/edit
	def edit
		@hypothesis_groups = HypothesisGroup.all
		@exercise_hypotheses = ExerciseHypothesis.where(exercise: @conclusion.subtask.task.exercise)
		@task = @conclusion.subtask.task
		set_view_layout
	end

	def create

		@task = Task.new(name:conclusion_params[:title], exercise: current_exercise)
		@task.level = Task.get_highest_level(@task.exercise) + 1

		# This can be done for each different type of subtask in their respective controllers
		subtask = @task.subtasks.build
		@conclusion = subtask.build_conclusion(title:conclusion_params[:title], content:conclusion_params[:content], exercise_hypothesis_id:conclusion_params[:exercise_hypothesis_id])

		respond_to do |format|
			if @conclusion.save & @task.save
				subtask.save
				format.html { redirect_to edit_conclusion_path(@conclusion.id, :layout => get_layout), notice: 'Diagnoositoimenpide lisättiin onnistuneesti!' }
			else
				format.html { redirect_to new_conclusion_path(:layout => get_layout), alert: 'Diagnoositoimenpiteen lisääminen epäonnistui!' }
			end
		end
	end


	def json_create
		@task = Task.find(params[:task_id])

		# This can be done for each different type of subtask in their respective controllers
		subtask = @task.subtasks.build
		@conclusion = subtask.build_conclusion(title:conclusion_params[:title], content:conclusion_params[:content], exercise_hypothesis_id:conclusion_params[:exercise_hypothesis_id])

		respond_to do |format|
			if @conclusion.save
				subtask.save
				format.html { redirect_to edit_conclusion_path(@conclusion.id, :layout => get_layout), notice: 'Diagnoositoimenpide lisättiin onnistuneesti!' }
				format.json { render json: @conclusion }
			else
				format.html { redirect_to new_conclusion_path(:layout => get_layout), alert: 'Diagnoositoimenpiteen lisääminen epäonnistui!' }
				format.json { head :internal_server_error }
			end
		end
	end

	def update
		@task = @conclusion.subtask.task
		respond_to do |format|
			if @conclusion.update(conclusion_params) & @task.update(name:conclusion_params[:title])
				format.html { redirect_to edit_conclusion_path(@conclusion.id, :layout => get_layout), notice: 'Diagnoositoimenpide päivitettiin onnistuneesti!' }
			else
				format.html { redirect_to edit_conclusion_path(@conclusion.id, :layout => get_layout), alert: 'Diagnoosioimenpiteen päivitys epäonnistui!' }
			end
		end
	end

	def json_update
		respond_to do |format|
			if @conclusion.update(conclusion_params)
				format.html { redirect_to edit_conclusion_path(@conclusion.id, :layout => get_layout), notice: 'Diagnoositoimenpide päivitettiin onnistuneesti!' }
				format.json { render json: @conclusion }
			else
				format.html { redirect_to edit_conclusion_path(@conclusion.id, :layout => get_layout), alert: 'Diagnoosioimenpiteen päivitys epäonnistui!' }
				format.json { head :internal_server_error }
			end
		end
	end

	def destroy
		@task = @conclusion.subtask.task
		@task.destroy
		respond_to do |format|
			format.html { redirect_to tasks_path(:layout => get_layout), notice: 'Diagnoositoimenpide poistettu!' }
		end
	end

	def json_destroy
		@conclusion.subtask.update_levels_before_deleting
		@conclusion.subtask.destroy
		respond_to do |format|
			format.html { redirect_to tasks_path(:layout => get_layout), notice: 'Diagnoositoimenpide poistettu!' }
			format.json { head :ok }
		end
	end

	def check_answers
		respond_to do |format|
			if @conclusion.user_answered_correctly?(@current_user, check_conclusion_params[:exhyp_id])
				if params[:current_task_id]
					task = Task.find params[:current_task_id]
					@current_user.check_all_hypotheses(task.exercise)
				else
					@current_user.check_all_hypotheses(current_task.exercise)
				end

				if params[:current_exercise_id]
					exercise = Exercise.find params[:current_exercise_id]
					exercise_is_completed = @current_user.has_completed?(exercise)
				else
					exercise_is_completed = @current_user.has_completed?(current_exercise)
				end

				if exercise_is_completed
					format.html {  redirect_to task_path(@conclusion.subtask.task, :layout => get_layout,
																							 :last_clicked_conclusion => check_conclusion_params[:exhyp_id]),
																		 notice: 'Onneksi olkoon suoritit casen!'  }
					format.json { head :accepted }
				else
					format.html {  redirect_to task_path(@conclusion.subtask.task, :layout => get_layout,
																							 :last_clicked_conclusion => check_conclusion_params[:exhyp_id]),
																		 notice: 'Hyvä, selvitit oikean diagnoosin!'  }
					format.json { head :ok }
				end

			else
				exhyp = ExerciseHypothesis.find(check_conclusion_params[:exhyp_id])
				@current_user.check_hypothesis(exhyp)
				format.html { redirect_to task_path(@conclusion.subtask.task, :layout => get_layout, :last_clicked_conclusion => check_conclusion_params[:exhyp_id]), notice: 'Väärä diffi poissuljettu!' }
				format.json { head :not_acceptable  }
			end
		end
	end

	private

	def conclusion_params
		params.require(:conclusion).permit(:title, :content, :exercise_hypothesis_id, :task_id)
	end

	def set_conclusion
		@conclusion = Conclusion.find(params[:id])
	end

	def check_conclusion_params
		params.permit(:exhyp_id)
	end


end