class CheckedHypothesesController < ApplicationController
  before_action :set_checked_hypothesis, only: [:destroy]
  before_action :ensure_user_is_logged_in

  # POST /checked_hypotheses
  # POST /checked_hypotheses.json
  def create
    @checked_hypothesis = CheckedHypothesis.new(checked_hypothesis_params)
    exHyp = ExerciseHypothesis.find_by(id: checked_hypothesis_params[:exercise_hypothesis_id])
    unless(exHyp.nil?)
      if(exHyp.user_meets_requirements(current_user))
        respond_to do |format|
          if @checked_hypothesis.save
            format.html { redirect_to hypotheses_url(:layout => get_layout, :last_clicked_hypothesis_id => checked_hypothesis_params[:exercise_hypothesis_id])}
          else
            format.html { redirect_to hypotheses_url(:layout => get_layout), alert: "Hypoteesin poisto epäonnistui" }
          end
        end
      else
        redirect_to hypotheses_url(:layout => get_layout, :last_clicked_hypothesis_id => checked_hypothesis_params[:exercise_hypothesis_id]), alert: "Sinulla ei ole vielä tarpeeksi tietoa voidaksesi poissulkea työhypoteesin."
      end
    else
      redirect_to hypotheses_url(:layout => get_layout, :last_clicked_hypothesis_id => checked_hypothesis_params[:exercise_hypothesis_id]), alert: "Sinulla ei ole vielä tarpeeksi tietoa voidaksesi poissulkea työhypoteesin."
    end
  end

  # DELETE /checked_hypotheses/1
  # DELETE /checked_hypotheses/1.json
  def destroy
    @checked_hypothesis.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url(:layout => get_layout), notice: 'Työhypoteesi palautettu mahdollisten työhypoteesien listaan.'}
      format.json { head :no_content }
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
