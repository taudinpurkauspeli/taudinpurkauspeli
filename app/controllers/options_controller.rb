class OptionsController < ApplicationController
  before_action :set_option, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin

  def show
    set_view_layout
  end

  def new
    @option = Option.new

    set_view_layout
  end

  def edit
    set_view_layout
  end

  def create
    @task = Task.find(session[:task_id])
    @option = Option.new(option_params)

    respond_to do |format|
      if @option.save
        # if radio button type
        if @option.multichoice.is_radio_button == true
          uncheck_other_options(@option)
        end
        #subtask.save
        format.html { redirect_to edit_multichoice_path(@option.multichoice.id, :layout => get_layout), notice: 'Vaihtoehto lisättiin onnistuneesti.' }
        format.json { render :show, status: :created, location: @option }
      else
        format.html { redirect_to edit_multichoice_path(Multichoice.find(option_params[:multichoice_id]), :layout => get_layout), alert: 'Vaihtoehdonn tiedot puuttelliset.' }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_texts/1
  # PATCH/PUT /task_texts/1.json
  def update
    respond_to do |format|
      if @option.update(option_params)
        # if radio button type
        if @option.multichoice.is_radio_button == true
          uncheck_other_options(@option)
        end
        format.html { redirect_to edit_multichoice_path(@option.multichoice.id, :layout => get_layout), notice: 'Vaihtoehto päivitettiin onnistuneesti.' }
      else
        format.html { redirect_to edit_multichoice_path(@option.multichoice.id, :layout => get_layout), alert: 'Vaihtoehdon päivitys epäonnistui!.' }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    parent_id = @option.multichoice_id
    @option.destroy
    respond_to do |format|
      format.html { redirect_to edit_multichoice_path(parent_id, :layout => get_layout), notice: 'Vastausvaihtoehdon poisto onnistui!' }
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
  # Unchecks other options when updated option is corrent answer
  def uncheck_other_options(option)
    if option.is_correct_answer == 1
      option.multichoice.options.where.not(id: @option.id).each do |opt|
        opt.is_correct_answer = 0
        opt.save
      end
    end
  end

end