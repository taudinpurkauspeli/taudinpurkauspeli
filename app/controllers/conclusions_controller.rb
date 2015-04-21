class ConclusionsController < ApplicationController
	before_action :ensure_user_is_logged_in
	before_action :ensure_user_is_admin, except: [:index, :show, :check_answers]
	before_action :set_conclusion, only: [:edit, :update, :check_answers, :destroy]

	def show
		set_view_layout
	end

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
		set_view_layout
	end

	def create

		@task = Task.new(name:conclusion_params[:title], exercise: current_exercise)
		@task.level = Task.get_highest_level(@task.exercise) + 1

		# This can be done for each different type of subtask in their respective controllers
		subtask = @task.subtasks.build
		@conclusion = subtask.build_conclusion(title:conclusion_params[:title], content:conclusion_params[:content], exercise_hypothesis_id:conclusion_params[:exercise_hypothesis_id],)

		respond_to do |format|
			if @conclusion.save & @task.save
				subtask.save
				format.html { redirect_to edit_conclusion_path(@conclusion.id, :layout => get_layout), notice: 'Päätöstoimenpide lisättiin onnistuneesti.' }
				#format.json { render :show, status: :created, location: @multichoice }
			else
				## TODO redirect task show
				format.html { redirect_to new_conclusion_path(:layout => get_layout), alert: 'Päätöstoimenpiteen lisääminen epäonnistui.' }
				format.json { render json: @conclusion.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @conclusion.update(conclusion_params)
				format.html { redirect_to edit_conclusion_path(@conclusion.id, :layout => get_layout), notice: 'Päätöstoimenpide päivitettiin onnistuneesti.' }
			else
				format.html { redirect_to edit_conclusion_path(@conclusion.id, :layout => get_layout), alert: 'Toimenpiteen päivitys epäonnistui.' }
				format.json { render json: @conclusion.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@conclusion.destroy
		respond_to do |format|
			format.html { redirect_to tasks_path(:layout => get_layout), notice: 'Taskin poisto onnistui!' }
			format.json { head :no_content }
		end
	end

	def check_answers
		respond_to do |format|
			if @conclusion.user_answered_correctly?(current_user, check_conclusion_params[:exhyp_id])
				session[:exhyp_id] = nil
				current_user.check_all_hypotheses(current_task.exercise)
				format.html { redirect_to task_path(@conclusion.subtask.task, :layout => get_layout), notice: 'Valitsit oikein!' }
			else
				exhyp = ExerciseHypothesis.find(check_conclusion_params[:exhyp_id])
				session[:exhyp_id] = check_conclusion_params[:exhyp_id]
				current_user.check_hypothesis(exhyp)
				format.html { redirect_to task_path(@conclusion.subtask.task, :layout => get_layout, :wrong_conclusion => check_conclusion_params[:exhyp_id]), alert: 'Valitsit väärin!' }

			end
		end
	end

	private

	def conclusion_params
		params.require(:conclusion).permit(:title, :content, :exercise_hypothesis_id)
	end

	def set_conclusion
		@conclusion = Conclusion.find(params[:id])
	end

	def check_conclusion_params
		params.permit(:exhyp_id)
	end


end