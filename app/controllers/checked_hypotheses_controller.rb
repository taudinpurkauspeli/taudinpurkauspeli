class CheckedHypothesesController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :ensure_user_is_logged_in
  before_action :set_checked_hypothesis, only: [:destroy]
  before_action :set_current_user, only: [:create, :index]

  def index

    exercise = Exercise.find(params[:exercise_id])

    respond_to do |format|
      if exercise && @current_user

        checked_hypotheses = @current_user.checked_hypotheses.joins(:exercise_hypothesis).where(exercise_hypotheses: {exercise_id: exercise.id})

        format.html
        format.json { render json: checked_hypotheses }
      else
        format.html
        format.json { head :not_found }
      end
    end

  end

  # POST /checked_hypotheses
  # POST /checked_hypotheses.json
  def create
    @checked_hypothesis = CheckedHypothesis.new(checked_hypothesis_params)
    exHyp = ExerciseHypothesis.find_by(id: checked_hypothesis_params[:exercise_hypothesis_id])
    respond_to do |format|
      unless(exHyp.nil?)
        if(exHyp.user_meets_requirements(@current_user))

          if @checked_hypothesis.save
            format.html { redirect_to hypotheses_url(:layout => get_layout, :last_clicked_hypothesis_id => checked_hypothesis_params[:exercise_hypothesis_id])}
            format.json { head :ok }
          else
            format.html { redirect_to hypotheses_url(:layout => get_layout), alert: "Hypoteesin poisto epäonnistui" }
            format.json { head :internal_server_error }
          end
        else
          format.html { redirect_to hypotheses_url(:layout => get_layout, :last_clicked_hypothesis_id => checked_hypothesis_params[:exercise_hypothesis_id]), alert: "Sinulla ei ole vielä tarpeeksi tietoa voidaksesi poissulkea diffin." }
          format.json { head :not_acceptable }
        end
      else
        format.html { redirect_to hypotheses_url(:layout => get_layout, :last_clicked_hypothesis_id => checked_hypothesis_params[:exercise_hypothesis_id]), alert: "Sinulla ei ole vielä tarpeeksi tietoa voidaksesi poissulkea diffin." }
        format.json { head :not_acceptable }
      end
    end
  end

  # DELETE /checked_hypotheses/1
  # DELETE /checked_hypotheses/1.json
  def destroy
    @checked_hypothesis.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url(:layout => get_layout), notice: 'Diffi palautettu mahdollisten diffien listaan.'}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_checked_hypothesis
    @checked_hypothesis = CheckedHypothesis.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def checked_hypothesis_params
    params.require(:checked_hypothesis).permit(:exercise_hypothesis_id, :user_id)
  end
end
