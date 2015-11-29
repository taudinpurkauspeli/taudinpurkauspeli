class ExerciseHypothesesController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin
  before_action :set_exercise_hypothesis, only: [:update, :destroy]

  # GET /exercise_hypotheses
  # GET /exercise_hypotheses.json
  def index
    exercise = Exercise.find(params[:exercise_id])

    respond_to do |format|
      if exercise

        exercise_hypotheses = exercise.get_hypotheses
        hypothesis_bank = exercise.get_hypothesis_bank

        response = {exercise_hypotheses: exercise_hypotheses, hypothesis_bank: hypothesis_bank}

        format.html
        format.json {render json: response}
      else
        format.html
        format.json {head :not_found}
      end
    end

  end

  # POST /exercise_hypotheses
  # POST /exercise_hypotheses.json
  def create
    @exercise_hypothesis = ExerciseHypothesis.new(exercise_hypothesis_params)
    # Set anamnesis id
    @exercise_hypothesis.task_id = @exercise_hypothesis.exercise.tasks.find_by(level:0).id

    respond_to do |format|
      if @exercise_hypothesis.save
        format.html { redirect_to hypotheses_url(:layout => get_layout)}
      else
        format.html { redirect_to hypotheses_url(:layout => get_layout), alert: 'Diffin liittäminen caseen epäonnistui.' }
      end
    end
  end

  # PATCH/PUT /exercise_hypotheses/1
  # PATCH/PUT /exercise_hypotheses/1.json
  def update
    respond_to do |format|
      if @exercise_hypothesis.update(exercise_hypothesis_params)
        format.html { redirect_to hypotheses_url(:layout => get_layout), notice: 'Diffin tiedot on päivitetty.' }
      else
        format.html { redirect_to hypotheses_url(:layout => get_layout), alert: 'Diffin päivittäminen epäonnistui.' }
      end
    end
  end

  # DELETE /exercise_hypotheses/1
  # DELETE /exercise_hypotheses/1.json
  def destroy
    @exercise_hypothesis.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url(:layout => get_layout), notice: 'Diffi poistettu casesta.'}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_exercise_hypothesis
    @exercise_hypothesis = ExerciseHypothesis.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def exercise_hypothesis_params
    params.require(:exercise_hypothesis).permit(:exercise_id, :hypothesis_id, :explanation, :task_id)
  end

  def exercise_hypothesis_other_params
    params.permit(:exercise_id)
  end
end
