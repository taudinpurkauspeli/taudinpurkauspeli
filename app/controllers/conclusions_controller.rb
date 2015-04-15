class ConclusionsController < ApplicationController

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

end