class OptionsController < ApplicationController
  before_action :set_option, only: [:show, :edit, :update]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin


 def show
  end
  
 def edit
    @option = Option.find(params[:id])
  end

  # def create
  #   @task = Task.find(session[:task_id])

  #   # This can be done for each different type of subtask in their respective controllers
  #   subtask = @task.subtasks.build
  #   @multichoice = subtask.build_multichoice(question:multichoice_params[:question])

  #   respond_to do |format|
  #     if @multichoice.save
  #       subtask.save
  #       format.html { redirect_to @multichoice.subtask.task, notice: 'Kysymys lisättiin onnistuneesti.' }
  #       #format.json { render :show, status: :created, location: @multichoice }
  #     else
  #       #format.html { render :new }
  #       format.json { render json: @multichoice.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /task_texts/1
  # PATCH/PUT /task_texts/1.json
  def update
    respond_to do |format|
      if @option.update(option_params)
        format.html { redirect_to edit_task_path(@option.multichoice.subtask.task.id), notice: 'Vaihtoehto päivitettiin onnistuneesti.' }
      else
        #format.html { render :edit }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end


 private
  # Use callbacks to share common setup or constraints between actions.
  	def set_option
    	@option = Option.find(params[:id])
  	end
   # Never trust parameters from the scary internet, only allow the white list through.
  	def option_params
    	params.require(:option).permit(:content, :value, :explanation)
  end

 end