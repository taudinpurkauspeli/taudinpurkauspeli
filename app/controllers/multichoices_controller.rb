class MultichoicesController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:check_answers]
  before_action :set_multichoice, only: [:edit, :update, :destroy, :check_answers, :show]
  before_action :set_current_user, only: [:check_answers]

  def new
    @multichoice = Multichoice.new

    set_view_layout
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @multichoice }
    end
  end

  # GET /multichoices/1/edit
  def edit
    @multichoice = Multichoice.find(params[:id])
    @new_option = Option.new
    @is_correct_answers = Option.is_correct_answers

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
        format.html { redirect_to edit_multichoice_path(@multichoice.id, :layout => get_layout), notice: 'Kysymys lisättiin onnistuneesti!' }
      else
        format.html { redirect_to new_multichoice_path(:layout => get_layout), alert: 'Kysymyksen lisääminen epäonnistui!' }
      end
    end
  end


  def json_create
    @task = Task.find(params[:task_id])

    # This can be done for each different type of subtask in their respective controllers
    subtask = @task.subtasks.build
    @multichoice = subtask.build_multichoice(question:multichoice_params[:question], is_radio_button:multichoice_params[:is_radio_button])

    respond_to do |format|
      if @multichoice.save
        subtask.save
        format.html { redirect_to edit_multichoice_path(@multichoice.id, :layout => get_layout), notice: 'Kysymys lisättiin onnistuneesti!' }
        format.json { render json: @multichoice }
      else
        format.html { redirect_to new_multichoice_path(:layout => get_layout), alert: 'Kysymyksen lisääminen epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end

  # PATCH/PUT /task_texts/1
  # PATCH/PUT /task_texts/1.json
  def update
    respond_to do |format|
      if @multichoice.update(multichoice_params)
        format.html { redirect_to edit_multichoice_path(@multichoice.id, :layout => get_layout), notice: 'Kysymys päivitettiin onnistuneesti!' }
        format.json { head :ok }
      else
        @new_option = Option.new
        format.html { redirect_to edit_multichoice_path(@multichoice.id, :layout => get_layout), alert: 'Kysymyksen päivitys epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end

  # DELETE /multichoices/1
  # DELETE /multichoices/1.json
  def destroy
    @multichoice.subtask.update_levels_before_deleting
    @multichoice.destroy
    respond_to do |format|
      format.html
      format.json { head :ok }
    end
  end

  # TODO fix user_has_completed redirect logic
  # /multichoices/:id/check_answers'
  def check_answers
    respond_to do |format|
      if @multichoice.user_answered_correctly?(@current_user, checked_options_params[:checked_options].to_a)
        if @current_user.has_completed?(current_exercise)
          format.html { redirect_to task_path(@multichoice.subtask.task, :layout => get_layout, notice: "Onneksi olkoon suoritit casen!") }
        else
          format.html { redirect_to task_path(@multichoice.subtask.task, :layout => get_layout), notice: 'Valitsit oikein!' }
        end
      else
        format.html { redirect_to task_path(@multichoice.subtask.task, :layout => get_layout, :multichoice_checked_options => checked_options_params[:checked_options]), alert: 'Valinnoissa oli vielä virheitä!' }
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
    params.require(:multichoice).permit(:question, :is_radio_button, :task_id)

  end

  def checked_options_params
    params.permit(checked_options: [])
  end
end
