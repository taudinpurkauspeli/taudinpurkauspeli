class HypothesesController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :correct_diagnosis]
  before_action :set_hypothesis, only: [:destroy, :update]
  before_action :set_current_user, only: [:index]

  # GET /hypotheses
  # GET /hypotheses.json
  def index
    @exercise = current_exercise
    if @exercise
      @hypothesis_groups = HypothesisGroup.all

      @last_clicked_hypothesis_id = params[:last_clicked_hypothesis_id]

      if @current_user.try(:admin)
        @tasks = @exercise.tasks

        #new instances
        @new_exercise_hypothesis = ExerciseHypothesis.new
        @new_hypothesis_group = HypothesisGroup.new
        @new_hypothesis = Hypothesis.new
      else
        @correct_diagnosis = @exercise.correct_diagnosis

        @new_checked_hypothesis = CheckedHypothesis.new
      end

    else
      redirect_to exercises_path, alert: 'Valitse ensin case, jota haluat tarkastella!'
    end

  end


  # GET /hypotheses_all.json

  def hypotheses_all
    @hypotheses = Hypothesis.all

    respond_to do |format|
      format.html
      format.json {render json: @hypotheses}
    end
  end

  # GET /hypothesis_bank.json

  def hypothesis_bank
    exercise = Exercise.find(params[:exercise_id])

    respond_to do |format|
      if exercise

        hypothesis_bank = exercise.get_hypothesis_bank_json

        format.html
        format.json {render json: hypothesis_bank}
      else
        format.html
        format.json {head :not_found}
      end
    end
  end

  # GET /hypotheses/new
  def new
    @hypothesis = Hypothesis.new
  end

  def correct_diagnosis
    exercise = Exercise.find(params[:exercise_id])

    if exercise

      correct_diagnosis = exercise.correct_diagnosis

      respond_to do |format|
        if correct_diagnosis
          format.html
          format.json {render json: correct_diagnosis.to_json(include: :hypothesis)}
        else
          format.html
          format.json {head :not_found}
        end
      end


    end

  end

  # POST /hypotheses
  # POST /hypotheses.json
  def create
    @hypothesis = Hypothesis.new(hypothesis_params)
    respond_to do |format|
      if @hypothesis.save
        format.html { redirect_to hypotheses_path(:layout => get_layout), notice: 'Hypoteesin luominen onnistui!' }
        format.json { head :ok }
      else
        format.html { redirect_to hypotheses_path(:layout => get_layout), alert: 'Hypoteesin luominen epäonnistui!' }
        format.json { head :internal_server_error }
      end
    end
  end

  def update
    #TODO: Check what to do with Rails validations

    respond_to do |format|
      if @hypothesis.update(hypothesis_params)
        format.html
        format.json { head :ok }
      else
        format.html
        format.json { head :internal_server_error }
      end
    end
  end

  # DELETE /hypotheses/1
  # DELETE /hypotheses/1.json
  def destroy
    @hypothesis.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url(:layout => get_layout), notice: 'Hypoteesin poisto onnistui!' }
      format.json { head :ok }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hypothesis
    @hypothesis = Hypothesis.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hypothesis_params
    params.require(:hypothesis).permit(:name, :hypothesis_group_id)
  end
end
