class ConclusionsController < ApplicationController
	before_action :ensure_user_is_logged_in

	def show
		set_view_layout
	end

	def new
		@conclusion = Conclusion.new
		set_view_layout
	end

	# GET /conclusions/1/edit
	def edit
		set_view_layout
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
		params.require(:conclusion).permit(:title, :content)
	end

end