class ExerciseHypothesesController < ApplicationController
  before_action :set_exercise_hypothesis, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :show]

  # POST /exercise_hypotheses
  # POST /exercise_hypotheses.json
  def create
    @exercise_hypothesis = ExerciseHypothesis.new(exercise_hypothesis_params)

    respond_to do |format|
      if @exercise_hypothesis.save
        format.html { redirect_to hypotheses_url}
        format.json { render :show, status: :created, location: @exercise_hypothesis }
      else
         format.html { redirect_to hypotheses_url, alert: 'Työhypoteesin liittäminen caseen epäonnistui.' }
      end
    end
  end

  # PATCH/PUT /exercise_hypotheses/1
  # PATCH/PUT /exercise_hypotheses/1.json
  def update
    respond_to do |format|
      if @exercise_hypothesis.update(exercise_hypothesis_params)
        format.html { redirect_to hypotheses_url, notice: 'Työhypoteesin selite päivitetty.' }
        format.json { render :show, status: :ok, location: @exercise_hypothesis }
      else
         format.html { redirect_to hypotheses_url, alert: 'Työhypoteesin päivittäminen epäonnistui.' }
      end
    end
  end

  # DELETE /exercise_hypotheses/1
  # DELETE /exercise_hypotheses/1.json
  def destroy
    @exercise_hypothesis.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url, notice: 'Työhypoteesi poistettu casesta.'}
      format.json { head :no_content }
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
