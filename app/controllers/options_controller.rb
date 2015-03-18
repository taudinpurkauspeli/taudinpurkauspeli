class OptionsController < ApplicationController
  before_action :set_option, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin


  def show
  end

  def new
    @option = Option.new
  end

  def edit
  end

  def create
    @task = Task.find(session[:task_id])

    # This can be done for each different type of subtask in their respective controllers
    #subtask = @task.subtasks.build

    #multichoice = @task.subtasks.multichoice.build

    # @option = multichoice.build_option(content:option_params[:content], is_correct_answer:option_params[:is_correct_answer],
    #  explanation:option_params[:explanation], multichoice_id:option_params[:multichoice_id])

    @option = Option.new(option_params)

    respond_to do |format|
      if @option.save
        #subtask.save
        format.html { redirect_to edit_multichoice_path(@option.multichoice.id), notice: 'Vaihtoehto lisättiin onnistuneesti.' }
        format.json { render :show, status: :created, location: @option }
      else
        format.html { redirect_to edit_multichoice_path(Multichoice.find(option_params[:multichoice_id])), alert: 'Vaihtoehdonn tiedot puuttelliset.' }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_texts/1
  # PATCH/PUT /task_texts/1.json
  def update
    respond_to do |format|
      if @option.update(option_params)
        format.html { redirect_to edit_multichoice_path(@option.multichoice.id), notice: 'Vaihtoehto päivitettiin onnistuneesti.' }
      else
        format.html { render :edit }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    parent_id = @option.multichoice_id
    @option.destroy
    respond_to do |format|
      format.html { redirect_to edit_multichoice_path(parent_id), notice: 'Vastausvaihtoehdon poisto onnistui!' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_option
    @option = Option.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def option_params
    params.require(:option).permit(:content, :is_correct_answer, :explanation, :multichoice_id )
  end
end