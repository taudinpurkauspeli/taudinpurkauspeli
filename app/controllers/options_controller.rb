class OptionsController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:multichoice_index]
  before_action :set_option, only: [:update, :destroy]

  def index
    options = Option.where(multichoice_id: params[:multichoice_id]).joins(:title).order('titles.text').group_by(&:is_correct_answer)

    respond_to do |format|
      format.html
      format.json { render json: options.to_json(include: [:title]) }
    end
  end

  def only_options
    options = Option.where(multichoice_id: params[:multichoice_id])

    respond_to do |format|
      format.html
      format.json { render json: options.to_json(include: [:title]) }
    end
  end

  def multichoice_index
    options = Option.where(multichoice_id: params[:multichoice_id]).joins(:title).order('titles.text')

    respond_to do |format|
      format.html
      format.json { render json: options.to_json(include: [:title]) }
    end
  end

  def create
    @task = Task.find(session[:task_id])
    @option = Option.new(option_params)

    respond_to do |format|
      if @option.save
        # if radio button type
        if @option.multichoice.is_radio_button
          uncheck_other_options(@option)
        end
        format.html { redirect_to edit_multichoice_path(@option.multichoice.id, :layout => get_layout), notice: 'Vaihtoehto lisättiin onnistuneesti.' }
      else
        format.html { redirect_to edit_multichoice_path(Multichoice.find(option_params[:multichoice_id]), :layout => get_layout), alert: 'Vaihtoehdon tiedot puuttelliset.' }
      end
    end
  end

  def json_create
    @option = Option.new(option_params)

    respond_to do |format|
      if @option.save
        if @option.multichoice.is_radio_button
          uncheck_other_options(@option)
        end
        format.html { redirect_to edit_multichoice_path(@option.multichoice.id, :layout => get_layout), notice: 'Vaihtoehto lisättiin onnistuneesti.' }
        format.json { head :ok }
      else
        format.html { redirect_to edit_multichoice_path(Multichoice.find(option_params[:multichoice_id]), :layout => get_layout), alert: 'Vaihtoehdon tiedot puuttelliset.' }
        format.json { head :internal_server_error }
      end
    end
  end

  # PATCH/PUT /options/1
  # PATCH/PUT /options/1.json
  def update
    respond_to do |format|
      if @option.update(option_params)
        # if radio button type
        if @option.multichoice.is_radio_button
          uncheck_other_options(@option)
        end
        format.html { redirect_to edit_multichoice_path(@option.multichoice.id, :layout => get_layout), notice: 'Vaihtoehto päivitettiin onnistuneesti.' }
        format.json { head :ok }
      else
        format.html { redirect_to edit_multichoice_path(@option.multichoice.id, :layout => get_layout), alert: 'Vaihtoehdon päivitys epäonnistui!.' }
        format.json { head :internal_server_error }
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
    params.require(:option).permit(:title_id, :is_correct_answer, :explanation, :multichoice_id)
  end

  # Unchecks other options when updated option is corrent answer
  def uncheck_other_options(option)
    if option.is_correct_answer == "required"
      option.multichoice.options.where.not(id: @option.id).required.each do |opt|
        opt.is_correct_answer = "allowed"
        opt.save
      end
    end
  end

end