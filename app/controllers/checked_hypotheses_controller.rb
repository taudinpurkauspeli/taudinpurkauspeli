class CheckedHypothesesController < ApplicationController
  before_action :set_checked_hypothesis, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_is_logged_in

  # GET /checked_hypotheses/new
  def new
    @checked_hypothesis = CheckedHypothesis.new
  end

  # POST /checked_hypotheses
  # POST /checked_hypotheses.json
  def create
    @checked_hypothesis = CheckedHypothesis.new(checked_hypothesis_params)

    respond_to do |format|
      if @checked_hypothesis.save
        format.html { redirect_to hypotheses_url, notice: get_explanation(@checked_hypothesis)}
        format.json { render :show, status: :created, location: @checked_hypothesis }
      else
        format.html { render :new }
        format.json { render json: @checked_hypothesis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checked_hypotheses/1
  # DELETE /checked_hypotheses/1.json
  def destroy
    @checked_hypothesis.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url, notice: 'Työhypoteesi palautettu mahdollisten työhypoteesien listaan.'}
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

  # Returns a string that contains hypothesis name and explanation if any
  def get_explanation (checked_hypothesis)
    ex_hyp = @checked_hypothesis.exercise_hypothesis
    notice = "Työhypoteesi \"" + ex_hyp.hypothesis.name + "\" poissuljettu."
    unless ex_hyp.explanation.nil?
      notice += " Perustelu: " + ex_hyp.explanation
    end    
    return notice
  end
end
