class ConclusionsController < ApplicationController
	before_action :ensure_user_is_logged_in
	before_action :ensure_user_is_admin, except: [:index, :show]
	before_action :set_conclusion, only: [:edit, :update, :destroy]

	def show
		set_view_layout
	end

	def new
		@exercise_hypotheses = ExerciseHypothesis.where(exercise: current_task.exercise)
		@conclusion = Conclusion.new
		set_view_layout
	end

	# GET /conclusions/1/edit
	def edit
		@exercise_hypotheses = ExerciseHypothesis.where(exercise: current_task.exercise)
		set_view_layout
	end

	def create
		@task = Task.find(session[:task_id])

		# This can be done for each different type of subtask in their respective controllers
		subtask = @task.subtasks.build
		@conclusion = subtask.build_conclusion(title:conclusion_params[:title], content:conclusion_params[:content])

		respond_to do |format|
			if @conclusion.save
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

	private

	def conclusion_params
		params.require(:conclusion).permit(:title, :content, :exercise_hypothesis_id)
	end

	def set_conclusion
		@conclusion = Conclusion.find(params[:id])
	end


end