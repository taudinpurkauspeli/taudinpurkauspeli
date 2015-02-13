class CheckedHypothesesController < ApplicationController
  before_action :set_checked_hypothesis, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_is_logged_in
  before_action :ensure_user_is_admin, except: [:index, :show]

  # GET /checked_hypotheses
  # GET /checked_hypotheses.json
  def index
    @checked_hypotheses = CheckedHypothesis.all
  end

  # GET /checked_hypotheses/1
  # GET /checked_hypotheses/1.json
  def show
  end

  # GET /checked_hypotheses/new
  def new
    @checked_hypothesis = CheckedHypothesis.new
  end

  # GET /checked_hypotheses/1/edit
  def edit
  end

  # POST /checked_hypotheses
  # POST /checked_hypotheses.json
  def create
    @checked_hypothesis = CheckedHypothesis.new(checked_hypothesis_params)

    respond_to do |format|
      if @checked_hypothesis.save
        format.html { redirect_to hypotheses_url, notice: "Uusi chekhyp"}
        format.json { render :show, status: :created, location: @checked_hypothesis }
      else
        format.html { render :new }
        format.json { render json: @checked_hypothesis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checked_hypotheses/1
  # PATCH/PUT /checked_hypotheses/1.json
  def update
    respond_to do |format|
      if @checked_hypothesis.update(checked_hypothesis_params)
        format.html { redirect_to hypotheses_url, notice: 'Chekattu hypoteesi päivitetty' }
        format.json { render :show, status: :ok, location: @checked_hypothesis }
      else
        format.html { render :edit }
        format.json { render json: @checked_hypothesis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checked_hypotheses/1
  # DELETE /checked_hypotheses/1.json
  def destroy
    @checked_hypothesis.destroy
    respond_to do |format|
      format.html { redirect_to hypotheses_url, notice: 'Cheked ei chekattu.'}
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
