class MultichoicesController < ApplicationController
  before_action :set_multichoice, only: [:edit, :update, :destroy, :check_answers]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :show, :check_answers]

  #  def index
  #   @multichoices = Multichoice.all
  # end
  def show
    set_view_layout
  end

  def new
    @multichoice = Multichoice.new

    set_view_layout
  end

  # GET /multichoices/1/edit
  def edit
    @multichoice = Multichoice.find(params[:id])
    @new_option = Option.new

    set_view_layout
  end

  def create
    @task = Task.find(session[:task_id])

    # This can be done for each different type of subtask in their respective controllers
    subtask = @task.subtasks.build
    @multichoice = subtask.build_multichoice(question:multichoice_params[:question], is_radio_button:multichoice_params[:is_radio_button])

    respond_to do |format|
      if @multichoice.save
        subtask.save
        format.html { redirect_to edit_multichoice_path(@multichoice.id, :layout => get_layout), notice: 'Kysymys lisättiin onnistuneesti.' }
        #format.json { render :show, status: :created, location: @multichoice }
      else
        format.html { render :new }
        format.json { render json: @multichoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_texts/1
  # PATCH/PUT /task_texts/1.json
  def update
    respond_to do |format|
      if @multichoice.update(multichoice_params)
        format.html { redirect_to edit_multichoice_path(@multichoice.id, :layout => get_layout), notice: 'Kysymys päivitettiin onnistuneesti.' }
      else
        @new_option = Option.new
        format.html { render :edit }
        format.json { render json: @multichoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # /multichoices/:id/check_answers'
  def check_answers
    respond_to do |format|
      if @multichoice.check_right_answers(checked_options_params[:checked_options].to_a)
        @multichoice.subtask.task.completed_tasks.create(user_id: current_user.id)

        format.html { redirect_to task_path(@multichoice.subtask.task, :layout => get_layout), notice: 'Valitsit oikein!' }
      else
        format.html { redirect_to task_path(@multichoice.subtask.task, :layout => get_layout), alert: 'Valinnoissa oli vielä virheitä!' }
      end
    end
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_multichoice
    @multichoice = Multichoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def multichoice_params
    params.require(:multichoice).permit(:question, :is_radio_button)

  end

  def checked_options_params
    params.permit(checked_options: [])
  end
end
