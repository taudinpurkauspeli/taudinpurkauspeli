class ExerciseHypothesesController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index]
  before_action :set_exercise_hypothesis, only: [:update, :destroy]

  # GET /exercise_hypotheses
  # GET /exercise_hypotheses.json
  def index
    exercise = Exercise.find(params[:exercise_id])

    respond_to do |format|
      if exercise

        exercise_hypotheses = exercise.get_hypotheses_json

        format.html
        format.json {render json: exercise_hypotheses}
      else
        format.html
        format.json {head :not_found}
      end
    end
  end

  # GET /exercise_hypotheses
  # GET /exercise_hypotheses.json
  def json_index
    exercise = Exercise.find(params[:exercise_id])

    respond_to do |format|
      if exercise
        format.html
        format.json {render json: exercise.exercise_hypotheses.to_json(include: :hypothesis)}
      else
        format.html
        format.json {head :not_found}
      end
    end
  end

  def only_exercise_hypotheses
    exercise = Exercise.find(params[:exercise_id])

    respond_to do |format|
      if exercise

        exercise_hypotheses = exercise.hypotheses.to_json

        format.html
        format.json {render json: exercise_hypotheses}
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
        format.json {head :ok}
      else
        format.html { redirect_to hypotheses_url(:layout => get_layout), alert: 'Diffin liittäminen caseen epäonnistui.' }
        format.json {head :internal_server_error}
      end
    end
  end

  # PATCH/PUT /exercise_hypotheses/1
  # PATCH/PUT /exercise_hypotheses/1.json
  def update
    respond_to do |format|
      if @exercise_hypothesis.update(exercise_hypothesis_params)
        format.html { redirect_to hypotheses_url(:layout => get_layout), notice: 'Diffin tiedot on päivitetty.' }
        format.json {head :ok}
      else
        format.html { redirect_to hypotheses_url(:layout => get_layout), alert: 'Diffin päivittäminen epäonnistui.' }
        format.json {head :internal_server_error}
      end
    end
  end

  # DELETE /exercise_hypotheses/1
  # DELETE /exercise_hypotheses/1.json
  def destroy
    @exercise_hypothesis.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url(:layout => get_layout), notice: 'Diffi poistettu casesta.'}
      format.json {head :ok}
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

end
